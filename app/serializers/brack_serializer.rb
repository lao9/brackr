class BrackSerializer < ActiveModel::Serializer
  attributes :id, :lat, :long, :distance

  def distance
    if @instance_options[:latlng]
      lat = @instance_options[:latlng].split(",")[0]
      long = @instance_options[:latlng].split(",")[1]
    else
      lat = 39.749598000000006
      long = -105.0004297
    end
    destination = "#{lat},#{long}"
    current_location = Geokit::LatLng.new(object.lat, object.long)
    current_location.distance_to(destination)
  end
end
