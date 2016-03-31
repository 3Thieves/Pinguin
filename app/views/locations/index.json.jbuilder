json.array!(@locations) do |location|
  json.extract! location, :id, :name, :address, :phone_number, :latitude, :longitude, :hours, :link, :notes
  if @lat_lng
    json.distance location.distance_to(@lat_lng).round(1)
  end
  json.coords [location[:latitude], location[:longitude]]

  #json.url location_url(location, format: :json)
end
