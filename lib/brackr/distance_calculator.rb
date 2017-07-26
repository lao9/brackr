module Brackr
  module Distance
    def calculate_distance(dest_latlng, current_lat, current_long)
      if dest_latlng
        lat = dest_latlng.split(",")[0]
        long = dest_latlng.split(",")[1]
      else
        lat = 39.749598000000006
        long = -105.0004297
      end
      destination = "#{lat},#{long}"
      current_location = Geokit::LatLng.new(current_lat, current_long)
      current_location.distance_to(destination)
    end
  end
end
