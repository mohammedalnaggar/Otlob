json.extract! order_user, :id, :order_id, :user_id, :status, :created_at, :updated_at
json.url order_user_url(order_user, format: :json)
