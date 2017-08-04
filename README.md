# Brackr

Brackr allows users to find a bike rack near them using Denver city data, navigate to those bike rack by using their current location, while also allowing citizens of Denver to crowd source the locations of new bike racks and comment or report bike rack issues to make commuting and locking up bikes safer and easier.

## Production

Brackr is currently hosted on Heroku: https://brackr.herokuapp.com/

**Notes:**
* You must allow Brackr to use your browser's current location.
* Bike rack locations are currently strictly limited to the city of Denver
* Locations are seeded courtesy of the [City of Denver's Open Data Catalog](https://www.denvergov.org/opendata/dataset/city-and-county-of-denver-bike-racks)

## Tutorial

You can watch a demo of the application [here](https://vimeo.com/228285482), which was given on Thursday, August 3rd at Turing School of Software & Design in Denver, Colorado.

On the first page, Brackr will find the 20 nearest bike racks to your current location.

![aug-01-2017 12-41-02](https://user-images.githubusercontent.com/4068853/28841239-cec2c880-76b6-11e7-8c27-c012bcf378c6.gif)

If you're not currently in Denver, or there are any issues with obtaining your current location, a pin will be dropped in the default location.

<img width="583" alt="screen shot 2017-08-04 at 9 49 03 am" src="https://user-images.githubusercontent.com/4068853/28971513-36f35a56-78fa-11e7-9395-2797878cd656.png">


You can select the pins on the map, or use the "nearest racks" to find a bike rack.

![aug-01-2017 12-42-27](https://user-images.githubusercontent.com/4068853/28841268-e9dfd630-76b6-11e7-961d-1d4da18e82a3.gif)

If you want to find the nearest bike racks to a certain location within Denver, use the search bar to find that location and Brackr will re-access the nearest bike racks to your desired location.

![aug-01-2017 12-43-53](https://user-images.githubusercontent.com/4068853/28841334-1f29ef9c-76b7-11e7-9d35-070beee22c9c.gif)

You can now also select the little arrow in the bottom right portion of the bike rack info window and you'll be launched into google maps:

<img width="302" alt="screen shot 2017-08-04 at 9 51 44 am" src="https://user-images.githubusercontent.com/4068853/28971612-9128c330-78fa-11e7-85cd-bc66f0a3d0b3.png">

If you want to add a bike rack, first you must be logged in. Then navigate to the "Add New Rack" menu option and type in a location or address closet to the new bike rack.

![add_step1](https://user-images.githubusercontent.com/4068853/28855575-eb3a4fd0-76fa-11e7-9d24-a211eef3cc76.gif)

Then drag the green icon to where the bike rack is located.

![aug-01-2017 20-48-43](https://user-images.githubusercontent.com/4068853/28855578-ee5b19e2-76fa-11e7-91f6-1aeb0c537a9c.gif)

Finally, confirm that the cross streets and owner information is correct, and your bike will be added!

![add_step3](https://user-images.githubusercontent.com/4068853/28855576-eb4e8cf2-76fa-11e7-83b9-bd29cc6423d4.gif)

## Setup Instructions

1. Clone down the branch (or fork and then clone down)

`git clone https://github.com/lao9/brackr.git`

2. Navigate into project root

`cd brackr`

3. Bundle project gems

`bundle install`

4. Setup environment keys

Obtain a google maps Geocode API key [here](https://developers.google.com/maps/documentation/geocoding/intro) and Map API Key [here](https://developers.google.com/maps/documentation/javascript/earthquakes#placing_basic_markers). There should be a button in the top right corner that says "Get a Key".

Next, you'll need to reach out to me (contact info below) to receive the POST_TO_BRACKS_KEY.

Then, using the [figaro](https://github.com/laserlemon/figaro) gem, run the following command in console:

`bundle exec figaro install`

Then, open the config/application.yml file created and add the following, pasting in the keys acquired from google:

```
GOOGLE_GEOCODE_KEY: [YOUR_KEY_HERE]
GOOGLE_MAP_KEY: [YOUR_KEY_HERE]
POST_TO_BRACKS_KEY: [YOUR_KEY_HERE]
```

5. Setup database

`rake db:setup`

6. Run tests

Check that tests are running by typing `rspec` in the console.

7. Run server 

Run `rails s` in the console and then navigate to `http://localhost:3000` in your browser.


## Neat Gems

* Used [`gem 'geokit'`](https://github.com/geokit/geokit) to calculate the distances between the search location and each bike rack.
* Used [`gem 'figaro'`](https://github.com/laserlemon/figaro) to keep environment and key variables private


## API Services Used

Google Maps APIs:

* [Geocoding API](https://developers.google.com/maps/documentation/geocoding/intro): Finds cross streets for given latitude and longitude.
* [Maps Javascript API](https://developers.google.com/maps/documentation/javascript/earthquakes#placing_basic_markers): visualized bike rack marker data
* [Places API](https://developers.google.com/maps/documentation/javascript/examples/places-searchbox): Use google maps search box in Brackr map

## API Endpoints

### Default Brack Index

`GET /api/v1/bracks`

Returns collection of 20 brack objects sorted by distance closest to the default location (Turing School in Denver):

```
[
    {
        "id": 105,
        "lat": 39.7495666290001,
        "long": -105.000145148,
        "cross_streets": "LoDo",
        "owner": "City of Denver",
        "distance": 0.015287669880779668
    },
    {
        "id": 104,
        "lat": 39.7498516350001,
        "long": -105.000461602,
        "cross_streets": "15th St & Blake St",
        "owner": "City of Denver",
        "distance": 0.017625856700506287
    },
    {
        "id": 106,
        "lat": 39.7497392130001,
        "long": -105.000707391,
        "cross_streets": "1500",
        "owner": "City of Denver",
        "distance": 0.017706108128404854
    }
]

```

### Brack Index with LatLng Params

`GET /api/v1/bracks?latlng=39.750596200000004,-104.9964367`

Returns collection of 20 brack objects sorted by distance closest to the given location in params:

```
[
    {
        "id": 383,
        "lat": 39.7505684980001,
        "long": -104.996696391,
        "cross_streets": "17th St & Market St",
        "owner": "City of Denver",
        "distance": 0.013942751541404737
    },
    {
        "id": 59,
        "lat": 39.7503440410001,
        "long": -104.996195264,
        "cross_streets": "LoDo",
        "owner": "City of Denver",
        "distance": 0.02165838893241953
    },
    {
        "id": 365,
        "lat": 39.75017166,
        "long": -104.996291989,
        "cross_streets": "17th St & Lawrence St",
        "owner": "City of Denver",
        "distance": 0.03035737996761881
    }
]

```

### Create New Brack with User, Lat, Long, and Token Params

`POST /api/v1/bracks?brack[user_id]=1&brack[lat]="39.7505962"&brack[long]="-104.9964367"&brack[token]=[YOUR_TOKEN_HERE]`

Returns the newly added Brack:

```
{
    "id": 576,
    "lat": 39.7505962,
    "long": -104.9964367,
    "cross_streets": "Curtis Park",
    "owner": "Turing School",
    "distance": 1.013942751541404737
}

```


## Upcoming Features

* Seed with [Denver B-Cycle Data](https://denver.bcycle.com/pages-in-top-navigation/map)
* Allow users to add comments
* Allow users to save their favorite bike rack location

## Contact Information

Creator: Lauren Oliveri

Email: lauren.oliveri.9@gmail.com

