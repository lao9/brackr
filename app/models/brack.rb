require 'brackr/distance_calculator'

class Brack < ApplicationRecord
  include Brackr::Distance
  validates :lat, :long, presence: true

  def self.sort_by_distance(latlng)
    all.sort_by do |brack|
      brack.calculate_distance(latlng, brack.lat, brack.long)
    end.take(20)
  end

  def self.add_new(params)
    return new() unless params[:token] == ENV['POST_TO_BRACKS_KEY']
    # set lat and long
    lat = params[:lat]
    long = params[:long]
    # set user
    owner = User.find(params[:user_id]).generate_username
    # get cross_streets
    lat_long = {lat: lat, long: long}
    cross_streets = CrossStreetService.find_by_coordinates(lat_long)
    # create new instance
    new(cross_streets: cross_streets, lat: lat, long: long, owner: owner)
  end
end
