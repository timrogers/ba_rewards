# BA Rewards

This gem makes it easy to get usually difficult-to-access information
on the availability of British Airways reward flights.

I use the private API from the new [Avios](http://www.avios.com) Flight Finder app for iOS to grab this data. Thanks to Raffles at [Head for Points](http://www.headforpoints.com/2014/06/28/avios-flight-finder-app-launched/) for covering this very helpful little app.

## Usage

Pretty simple. First, add the gem to your Gemfile:

```
gem 'ba_rewards', github: 'timrogers/ba_rewards'
```

Simply call `BARewards.availability` with the code of your
departure and destinations airports. You can then optionally choose a fare class (I'll assume Economy) and the number of seats you need:

```ruby
require 'ba_rewards'

# I'm looking for two seats from any London airport to San Francisco in Business
result = BARewards.availability("LON", "SFO", :business, 2)
```

It'll return a `BARewards::Result` object, or raise an error if something goes wrong. You can call the following methods on the result object:

* __city__ - the destination city as text, converted from the provided airport code
* __country__ - the country that the destination city is located in
* __region__ - the region that the destination city is located in (probably pointless)
* __avios_price__ - the Avios price for a return ticket (excluding taxes and the like)
* __reward_flight_saver?__ - is this destination part of Avios's (rather excellent) Reward Flight Saver [scheme](http://www.avios.com/gb/en_gb/spend/reward-flight-saver)?
* __availability_dates__ - an array of Ruby Date objects, representing the dates in the next year where your requested number of seats are availability in the requested class
* __raw\_response__ - an `HTTParty::Response` object returned from the request to the Avios private API

## Colophon

Released by [Tim Rogers](http://timrogers.uk) ([@timrogers](https://twitter.com/timrogers)) under the MIT license. Any questions? Email <barewards@timrogers.co.uk>. 