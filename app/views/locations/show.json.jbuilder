json.extract! @location, :id, :name, :address, :phone_number, :latitude, :longitude, :hours, :link, :notes
json.coords [@location[:latitude], @location[:longitude]]
