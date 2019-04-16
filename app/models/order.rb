class Order < ApplicationRecord
    enum status: [ :waiting, :finished]
    belongs_to :user
    has_many :order_users , dependent: :destroy
    has_many :users, through: :order_users
end
