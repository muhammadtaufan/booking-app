module RequestHelper
  def auth_headers(client)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

    if client
      headers['X-API-CLIENT'] = client.name
      headers['X-API-SECRET'] = client.secret
    end
    headers
  end
end
