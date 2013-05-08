class RunKeeperTokenFetcher < Struct.new(:listener, :code)
  def fetch_access_token
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(payload)
    http.use_ssl = true
    request["Content-Type"] = "application/x-www-form-urlencoded"
    response = http.request(request)
    response_json = JSON.parse(response.body)
    if response_json["access_token"].present?
      listener.fetched_runkeeper_token(response_json["access_token"])
    else
      listener.runkeeper_token_error
    end
  end

  def uri
    URI.parse(RunKeeper::ACCESS_TOKEN_URL)
  end

  def payload
    {
      grant_type: 'authorization_code',
      code: code,
      client_id: RunKeeper::CLIENT_ID,
      client_secret: RunKeeper::CLIENT_SECRET,
      redirect_uri:  RunKeeper::REDIRECT_URI
    }
  end
end
