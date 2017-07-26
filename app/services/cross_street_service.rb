class CrossStreetService

  def initialize(coordinates)
    @conn = Faraday.new("https://maps.googleapis.com")
    @search_params = {
      latlng: "#{coordinates[:lat]},#{coordinates[:long]}",
      key: ENV['GOOGLE_GEOCODE_KEY']
    }
  end

  def find_by_coordinates
    response = conn.get("/maps/api/geocode/json", search_params)
    JSON.parse(response.body, symbolize_names: true)[:results][1][:address_components][0][:long_name]
  end

  def self.find_by_coordinates(coordinates)
    service = CrossStreetService.new(coordinates)
    service.find_by_coordinates
  end

  private
    attr_reader :search_params, :conn

end
