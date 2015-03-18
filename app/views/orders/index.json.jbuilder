json.array!(@orders) do |order|
  json.extract! order, :id, :order_date, :doctor_id, :trial_type_id, :conclusion, :tracking_number, :trials_id, :comment
  json.url order_url(order, format: :json)
end
