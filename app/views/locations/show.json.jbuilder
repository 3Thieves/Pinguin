json.extract! @location, :id, :name, :address, :created_at, :updated_at
json.coords [@location[:latitude], @location[:longitude]]
