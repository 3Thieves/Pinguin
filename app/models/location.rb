require 'date'
class Location < ActiveRecord::Base
   serialize :hours, Hash
   geocoded_by :address               # can also be an IP address
   after_validation :geocode          # auto-fetch coordinates
end
