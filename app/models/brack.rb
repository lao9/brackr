class Brack < ApplicationRecord
  validates :lat, :long, presence: true

  def self.sort_by_distance(latlng)
    if latlng
      lat = latlng.split(",")[0]
      long = latlng.split(",")[1]
    else
      lat = 39.749598000000006
      long = -105.0004297
    end
    current_location = Geokit::LatLng.new(lat, long)
    all.sort_by {|brack| brack.calculate_distance(current_location) }.take(20)
  end

  def calculate_distance(current_location)
    destination = "#{lat},#{long}"
    current_location.distance_to(destination)
  end

end
