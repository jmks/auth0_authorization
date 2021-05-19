module Auth0Authorization
  class User
    def initialize(raw)
      @raw = raw
    end

    def id
      @raw.fetch("user_id")
    end

    def email
      @raw.fetch("email")
    end

    def to_s
      "#{email} (#{id})"
    end
  end
end
