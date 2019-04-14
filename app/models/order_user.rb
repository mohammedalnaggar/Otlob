class OrderUser < ApplicationRecord
  enum status: [ :pinding, :joined]
  belongs_to :order
  belongs_to :user
  has_many :order_details, dependent: :destroy
end
