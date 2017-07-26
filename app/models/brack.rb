require 'brackr/distance_calculator'

class Brack < ApplicationRecord
  include Brackr::Distance
  validates :lat, :long, presence: true

  def self.sort_by_distance(latlng)
    all.sort_by do |brack|
      brack.calculate_distance(latlng, brack.lat, brack.long)
    end.take(20)
  end
end
