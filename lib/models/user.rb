# User model
class UserSession < AuthLogic::Session::Base
end

class User
  class << self 
  
    def < klass
      return true if klass == ::ActiveRecord::Base
      super(klass)
    end
  
    alias validates_length_of         validates_length
    alias validates_uniqueness_of     validates_is_unique
    alias validates_confirmation_of   validates_is_confirmed
    alias validates_presence_of       validates_present
    alias validates_format_of         validates_format
    alias validates_numericality_of   validates_is_number
    
    def column_names
      properties.map {|property| property.name.to_s }
    end
    
    def named_scope name, options, &block
      define_method name do
        if block
          all(options.merge(block.call))
        else
          all(options)
        end
      end
    end
    
    def define_callbacks *callbacks
      callbacks.each do |method_name|
        callback = method_name.scan /^(before|after)/
        
        method = %{
          def #{method_name} method_sym, options={}, &block
            puts "Called #{method_name}: \#{method_sym}, \#{options.inspect}"
            if block_given?
              #{callback} :#{method_name}, method_sym, &block
            else
              #{callback} :#{method_name} do
                if options[:if]     
                  return false unless send(options[:if])
                end
                
                if options[:unless] 
                  return false if send(options[:unless])
                end
                
                send method_sym
              end
            end
          end
        }        
        
        puts method
        instance_eval method
        
        define_method method_name do; end
      end


    end
  end
  
  self.define_callbacks *%w(
    before_validation
    before_save
    after_save
  )
 
  property :id, Serial
  property :full_name, String, :length => 1000
  
  property :email, String, :index => true, :null => false, :length => 1000
  property :crypted_password, String, :length => 255, :null => false
  property :password_salt, String, :length => 255, :null => false
  property :persistence_token, String, :length => 255, :index => true, :null => false
  property :login_count, Integer, :default => 0, :null => false
  property :last_request_at, DateTime
  property :last_login_at, DateTime, :index => true
  property :current_login_at, DateTime
  property :last_login_ip, String
  property :current_login_ip, String
  property :openid_identifier, String
  
  property :type, Discriminator

  include Authlogic::ActsAsAuthentic::Base
  include Authlogic::ActsAsAuthentic::Email
  include Authlogic::ActsAsAuthentic::LoggedInStatus
  include Authlogic::ActsAsAuthentic::Login
  include Authlogic::ActsAsAuthentic::MagicColumns
  include Authlogic::ActsAsAuthentic::Password
  include Authlogic::ActsAsAuthentic::PerishableToken
  include Authlogic::ActsAsAuthentic::PersistenceToken
  include Authlogic::ActsAsAuthentic::RestfulAuthentication
  include Authlogic::ActsAsAuthentic::SessionMaintenance
  include Authlogic::ActsAsAuthentic::SingleAccessToken
  include Authlogic::ActsAsAuthentic::ValidationsScope

#  def self.db_setup?
#    true
#  end

  def self.find_with_case(field, value, sensitivity = true)
#    if sensitivity
#      send("find_by_#{field}", value)
#    else
#      first(:conditions => ["LOWER(#{quoted_table_name}.#{field}) = ?", value.downcase])
#    end
    first :email => value.downcase
  end

  def self.quoted_table_name
    "users"
  end

  def self.default_timezone
    :utc
  end

  def self.primary_key
    :id
  end

  alias changed? dirty?
  class << self
    alias find_by_id get
  end

  def to_param
    id.to_s
  end

  def method_missing method_name, *args, &block
    name = method_name.to_s
    super unless name[/_changed\?$/]
    dirty_attributes.include? name.scan /(.*)_changed\?$/
  end

  acts_as_authentic do |config|
    config.instance_eval do
      validates_uniqueness_of_email_field_options :scope => :id
      perishable_token_valid_for 24*60*60
      validates_length_of_password_field_options =
        {:on => :update, :minimum => 6, :if => :has_no_credentials?}
      validates_length_of_password_confirmation_field_options =
        {:on => :update, :minimum => 6, :if => :has_no_credentials?}
    end
  end

  def has_no_credentials?
    crypted_password.blank? && openid_identifier.blank?
  end

  def send_activation_email
    Pony.mail(
      :to => self.email,
      :from => "no-reply@example.com",
      :subject => "Activate your account",
      :body =>  "You can activate your account at this link: " +
                "http://example.com/activate/#{self.perishable_token}"
    )
  end

  def send_password_reset_email
    Pony.mail(
      :to => self.email,
      :from => "no-reply@example.com",
      :subject => "Reset your password",
      :body => "We have recieved a request to reset your password. " +
               "If you did not send this request, then please ignore this email.\n\n" +
               "If you did send the request, you may reset your password using the following link: " +
                "http://example.com/reset-password/#{self.perishable_token}"
    )
  end
end

