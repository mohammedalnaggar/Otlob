json.extract! order_detail, :id, :orderUser_id, :item, :amount, :price, :comment, :created_at, :updated_at
json.url order_detail_url(order_detail, format: :json)
