require "faraday"
require "faraday_middleware"

module Vismasign
  class Client
    BASE_URL = "https://vismasign.frakt.io/"
    attr_reader :identifier, :api_key, :adapter

    def initialize(identifier:, api_key:, adapter: Faraday.default_adapter)
      @identifier = identifier
      @api_key = api_key
      @adapter = adapter
    end

    def document
      DocumentResource.new(self)      
    end

    def invitation
      InvitationResource.new(self)
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter
      end
    end
  end
end
