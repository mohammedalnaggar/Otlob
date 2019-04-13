class OrderUser < ApplicationRecord
  enum status: [ :invited, :joined]
  belongs_to :order
  belongs_to :user
end
