class Brack < ApplicationRecord
  validates :lat, :long, presence: true
end
