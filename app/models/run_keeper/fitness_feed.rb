class RunKeeper::FitnessFeed
  def activities(user, no_earlier_than=Date.today - 1)
    uri = URI(RunKeeper::API_END_POINT + "/fitnessActivities")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    no_earlier_than_formatted = no_earlier_than.strftime("%Y-%m-%d")
    http.start do |h|
      request = Net::HTTP::Get.new "/fitnessActivities?noEarlierThan=#{no_earlier_than_formatted}"
      request["Authorization"] = "Bearer #{user.runkeeper_token}"
      request["Accept"] = "application/vnd.com.runkeeper.FitnessActivityFeed+json"
      resp = h.request(request)
      if resp.code == "200"
        JSON.parse(resp.body)["items"]
      else
        []
      end
    end
  end
end
