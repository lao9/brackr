# require 'rubygems'
require 'nokogiri'

@doc = Nokogiri::XML(File.open("bike_racks.kmz"))

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
