class OrderUser < ApplicationRecord
  enum status: [ :waiting, :finished]
  belongs_to :order
  belongs_to :user
end
