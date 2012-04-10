class User
  include MongoMapper::Document

  key :provider, String
  key :uid, String
  key :name, String

  many :operations
  
  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    user = User.new(
            :provider=>auth["provider"], 
            :uid=>auth["uid"], 
            :name=>auth["info"]["name"]) 
    user.save
    user
  end
end
