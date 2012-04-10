class Food
  include MongoMapper::Document

  key :name, String
  key :brand, String
  key :creator_uid, String

  many :operations

  validates_presence_of :name  
  validates_uniqueness_of :name
end
