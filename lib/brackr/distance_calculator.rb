module Brackr
  module Distance
    def set_latlng(dest_latlng)
      return "#{39.749598000000006},#{-105.0004297}" unless dest_latlng
      "#{dest_latlng.split(",")[0]},#{dest_latlng.split(",")[1]}"
    end

    def calculate_distance(dest_latlng, current_lat, current_long)
      destination = set_latlng(dest_latlng)
      current_location = Geokit::LatLng.new(current_lat, current_long)
      current_location.distance_to(destination)
    end
  end
end
