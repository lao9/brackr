# require 'rubygems'
require 'nokogiri'

class Loader
  def self.seed_coordinates
    @doc = Nokogiri::XML(File.open("bike_racks.kmz"))

    binding.pry
    
    @doc.css('Placemark').each do |placemark|
      name = placemark.css('name')
      coordinates = placemark.at_css('coordinates')

      if name && coordinates
        print name.text + ","
        coordinates.text.split(' ').each do |coordinate|
          (lon,lat,elevation) = coordinate.split(',')
          print "#{lat},#{lon}"
        end
        puts "\n"
      end
    end
  end
end

task :load => :environment do
  Loader.seed_coordinates
end
