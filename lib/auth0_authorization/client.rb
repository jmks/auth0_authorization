module Auth0Authorization
  class Client
    def initialize(auth_url:, extension_url:, client_id:, client_secret:, api_identifier:)
      @auth_url = auth_url
      @extension_url = extension_url
      @client_id = client_id
      @client_secret = client_secret
      @api_identifier = api_identifier
    end

    # Fetches and stores a token for API requests
    # MUST be called first
    # https://auth0.com/docs/extensions/authorization-extension/enable-api-access-to-authorization-extension
    def connect
      url = "#{@auth_url}/oauth/token"
      response = Request.new.post(url, {}, {
        grant_type: "client_credentials",
        client_id: @client_id,
        client_secret: @client_secret,
        audience: @api_identifier
      })

      if response.success?
        @token = Token.new(response.body)
      else
        oh_noes(url, response)
      end
    end

    def user(user_id)
      url = "#{@extension_url}/users/:user_id"
      response = authenticated_request.get(
        url,
        { user_id: user_id }
      )

      if response.success?
        User.new(response.body)
      else
        oh_noes(url, response)
      end
    end

    # TODO: pagination with over 100 users
    def users
      url = "#{@extension_url}/users"
      response = authenticated_request.get(url)

      if response.success?
        response.body["users"].map do |user|
          User.new(user)
        end
      else
        oh_noes(url, response)
      end
    end

    def groups(user_id)
      url = "#{@extension_url}/users/:user_id/groups"
      response = authenticated_request.get(url, { user_id: user_id })

      if response.success?
        response.body.map do |group|
          Group.new(group)
        end
      else
        oh_noes(url, response)
      end
    end

    private

    def authenticated_request
      @authenticated_request ||= Request.new(token: @token)
    end

    def oh_noes(url, response)
      raise <<~MSG
        Error requesting data from: #{url}

        #{response.code}
        #{response.body}
      MSG
    end
  end
end
