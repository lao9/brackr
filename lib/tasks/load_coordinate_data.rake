require 'nokogiri'

class Loader
  def self.seed_coordinates
    @doc = Nokogiri::XML(File.open("db/bike_racks.kml"))

    @doc.css("//coordinates").each do |raw_coordinate|
      coordinates = raw_coordinate.children.text.split(",")
      long = coordinates[0].to_f
      lat = coordinates[1].to_f
      cross_streets = CrossStreetService.find_by_coordinates({lat: lat, long: long})
      Brack.create(lat: lat, long: long, cross_streets: cross_streets, owner: "City of Denver")
      puts "Brack ##{Brack.last.id} located at #{Brack.last.cross_streets} created, with latitude of #{Brack.last.lat} and longitude of #{Brack.last.long}"
    end
  end
end

task :load => :environment do
  Loader.seed_coordinates
end
