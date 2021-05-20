module Auth0Authorization
  class Response
    def initialize(response)
      @raw = response
    end

    def code
      @raw.code
    end

    def success?
      code == "200"
    end

    def body
      JSON.parse(@raw.body)
    rescue JSON::ParserError
      @raw.body
    rescue TypeError, "no implicit conversion of nil into String"
      nil
    end
  end
end
