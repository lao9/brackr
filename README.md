# Brackr

Brackr allows users to find a bike rack near them using Denver city data, navigate to those bike rack by using their current location, while also allowing citizens of Denver to crowd source the locations of new bike racks and comment or report bike rack issues to make commuting and locking up bikes safer and easier.

## Installation Instructions

## Neat Gems

Used `gem 'geokit'` to calculate the distances between the search location and each bike rack.

## API Services Used

Google Maps APIs:

* Geocoding API: https://developers.google.com/maps/documentation/geocoding/intro

* Maps Javascript API: https://developers.google.com/maps/documentation/javascript/earthquakes#placing_basic_markers

## Project Internal API Endpoints


When a user makes a get request to api/v1/racks, we get a list of all rack objects
We'd typically expect a parameter of lat and long:
api/v1/racks?lat=[]&long=[]
This returns JSON of all racks, sorted by distance from the lat and long params.
Default limit is 20, but if a limit params is added, then it can be adjusted.
api/v1/racks?lat=[]&long=[]&limit=15
OR
api/v1/racks?limit=15



## Contact Information
