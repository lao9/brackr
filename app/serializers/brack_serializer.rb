require 'brackr/distance_calculator'

class BrackSerializer < ActiveModel::Serializer
  include Brackr::Distance
  attributes :id, :lat, :long, :cross_streets, :distance

  def distance
    calculate_distance(@instance_options[:latlng], object.lat, object.long)
  end
end
