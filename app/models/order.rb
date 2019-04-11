class Order < ApplicationRecord
    enum status: [ :waiting, :finished]
    belongs_to :user
end
