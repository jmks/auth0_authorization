module Auth0Authorization
  class Config
    attr_accessor :auth_url, :extension_url, :client_id, :client_secret, :api_identifier

    def update(options)
      options.each_pair { |key, value| public_send("#{key}=", value) }
    end
  end
end
