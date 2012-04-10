class Operation
  include MongoMapper::Document

  attr_accessor :user_id
  @user_id

  attr_accessor :food_id
  @food_id

  key :value, Integer
  key :date, Time

  belongs_to :user
  belongs_to :food
end
