module Auth0Authorization
  class Group
    def initialize(raw)
      @raw = raw
    end

    def id
      @raw.fetch("_id")
    end

    def name
      @raw.fetch("name")
    end

    def description
      @raw.fetch("description")
    end

    def to_s
      "#{name} (#{id})"
    end
  end
end
