require "cgi"
require "json"
require "net/http"
require "openssl"
require "uri"

require "auth0_authorization/client"
require "auth0_authorization/config"
require "auth0_authorization/request"
require "auth0_authorization/utils/url"
require "auth0_authorization/version"
require "auth0_authorization/wrappers/group"
require "auth0_authorization/wrappers/response"
require "auth0_authorization/wrappers/token"
require "auth0_authorization/wrappers/user"

module Auth0Authorization
  def self.configure(options = {})
    config.update(options) if options.any?
    yield(config) if block_given?
  end

  def self.config
    @@config ||= Config.new
    @@config
  end
end
