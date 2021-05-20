module Auth0Authorization
  # Returns a Auth0Response from a HTTP request to the Auth0 Authorization plugin API
  # url is a Rails-like route: "https://some-url/:with/paramers/:too"
  # params are the URL-params and will be URL encoded: { with: "abcd", too: 1234}
  class Request
    def initialize(token: nil)
      @token = token
    end

    def get(url, params = {})
      uri = URI(Auth0Authorization::Utils::URL.interpolate(url, params))

      Response.new(request(Net::HTTP::Get, uri))
    end

    def post(url, params = {}, body = {})
      uri = URI(Auth0Authorization::Utils::URL.interpolate(url, params))

      Response.new(request(Net::HTTP::Post, uri, body))
    end

    def patch(url, params = {}, body = {})
      uri = URI(Auth0Authorization::Utils::URL.interpolate(url, params))

      Response.new(request(Net::HTTP::Patch, uri, body))
    end

    private

    def request(klass, uri, body = {})
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      req = klass.new(uri)

      if body.any?
        req["Content-Type"] = "application/json"
        req.body = JSON.dump(body)
      end

      req["Authorization"] = @token.header if @token

      http.request(req)
    end
  end
end
