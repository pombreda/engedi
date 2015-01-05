json.array!(@periods) do |period|
  json.extract! period, 
  json.url period_url(period, format: :json)
end