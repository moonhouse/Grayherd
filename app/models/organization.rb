class Organization < ActiveRecord::Base
  has_many :seasons

  def as_json(options={})
    { name: name,
      id: id,
      subdomain: subdomain,
      username: username
    }
  end

  def authenticate(u,p)
    db_password = BCrypt::Password.new(password)
    return ((db_password == p) and (u.eql? username))
  end
end
