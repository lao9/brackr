require 'nokogiri'

class Loader
  def self.seed_coordinates
    @doc = Nokogiri::XML(File.open("db/bike_racks.kml"))

    @doc.css("//coordinates").each do |raw_coordinate|
      coordinates = raw_coordinate.children.text.split(",")
      lat = coordinates[0].to_f
      long = coordinates[1].to_f
      Brack.create(lat: lat, long: long)
      puts "Brack ##{Brack.last.id} created, with latitude of #{Brack.last.lat} and longitude of #{Brack.last.long}"
    end
  end
end

task :load => :environment do
  Loader.seed_coordinates
end
