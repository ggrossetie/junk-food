class Food
  include MongoMapper::Document

  key :name, String
  key :creator_uid, String
  key :remaining, Integer

  many :operations

  validates_presence_of :name
  validates_uniqueness_of :name
end
