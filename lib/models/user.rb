# User model
class User
  include DataMapper::Resource

  def username=(username)
    @username = username
  end

  def username
    @username
  end

  def password=(password)
    @password = password
  end

  def password
    @password
  end
end

