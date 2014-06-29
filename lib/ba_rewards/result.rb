module BARewards
  class Result
    attr_reader :city, :country, :region, :reward_flight_saver,
                :availability_dates, :raw_response, :avios_price

    def reward_flight_saver?
      @reward_flight_saver > 0
    end

    def initialize(args)
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
  end
end