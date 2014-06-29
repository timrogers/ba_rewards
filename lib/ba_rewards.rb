require 'httparty'
require 'ba_rewards/result'

module BARewards
  include HTTParty
  base_uri 'dev1-flightavail-avios.bitnamiapp.com:8080/flight-availability-ws'

  def self.availability(from, to, klass = :economy, number_of_seats = 1)
    if [:economy, :premium, :business, :first].include?(klass)
      klass = klass.to_s[0].capitalize
    else
      raise BARewardsException, "You must specify a valid fare class."
    end

    response = get(
      "/departure/cities/#{from}/destination/#{to}?obDate=" \
      "#{Date.today.strftime('%d%m%y')}&cabinClass=#{klass}&sc=X"
    )

    if response.code == 200
      begin
        return BARewards::Result.new(
          city: response["cityName"],
          country: response["countryName"],
          region: response["regionName"],
          reward_flight_saver: if response.has_key?("prices")
            response["prices"]["rfs"]
          end,
          availability_dates: parse_availability_dates(response, number_of_seats),
          avios_price: if response.has_key?("prices")
            response["prices"]["prices"]["A"]
          end,
          raw_response: response
        )
      rescue Exception => e
        raise BARewardsException, "The response couldn't be parsed - please" \
          " check the details entered."
      end
    else
      raise BARewardsException, "The server responded with an error."
    end
  end

  private

  def self.parse_availability_dates(response, number_of_seats)
    response["out"].map do |entry|
      Date.parse(entry["d"]) if entry["bs"].to_i >= number_of_seats
    end.compact
  end
end

class BARewardsException < StandardError; end;