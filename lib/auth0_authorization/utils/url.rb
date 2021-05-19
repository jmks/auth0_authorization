module Auth0Authorization
  module Utils
    module URL
      module_function

      def interpolate(url, params)
        url
          .scan(/:\w+\b/)
          .each_with_object({}) { |e, h| h[e.sub(":", "").to_sym] = e }
          .each_with_object(url) { |(key, str), u| u.gsub!(str, CGI.escape(params.fetch(key).to_s)) }
      end
    end
  end
end
