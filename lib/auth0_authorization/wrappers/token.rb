module Auth0Authorization
  # https://auth0.com/docs/flows/call-your-api-using-the-client-credentials-flow#request-tokens
  # e.g.
  # {
  # "access_token":"eyJz93a...k4laUWw",
  # "token_type":"Bearer",
  # "expires_in":86400
  # }
  class Token
    def initialize(raw)
      @raw = raw
    end

    def header
      "#{token_type} #{access_token}"
    end

    def token_type
      @token_type ||= @raw.fetch("token_type")
    end

    def access_token
      @access_token ||= @raw.fetch("access_token")
    end
  end
end
