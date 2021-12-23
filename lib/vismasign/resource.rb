require "time"
require "digest/md5"
require "base64"

module Vismasign
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def get_request(url, params: {}, headers: {})      
      handle_response client.connection.get(url, params, authorization_header(url, "GET").merge(headers))
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, authorization_header(url, "POST", body.to_json).merge(headers))
    end

    def authorization_header(path, http_verb, payload = "")
      date = Time.now.rfc2822
      md5_file = Digest::MD5.digest(payload.encode)
      content_md5 = Base64.strict_encode64(md5_file)
      digest = OpenSSL::Digest.new("sha512")
      key = Base64.decode64(client.api_key)
      authorization_header = [http_verb, content_md5, "application/json", date, path].join("\n")
      authorization_header_enc = "Onnistuu " + client.identifier + ":" + Base64.strict_encode64(OpenSSL::HMAC.digest(digest, key, authorization_header.encode))
      {"Content-MD5": content_md5, "Content-type": "application/json", Date: date, Authorization: authorization_header_enc}
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Your request was malformed. #{response.body["error"]}"
      when 401
        raise Error, "You did not supply valid authentication credentials. #{response.body["error"]}"
      when 403
        raise Error, "You are not allowed to perform that action. #{response.body["error"]}"
      when 404
        raise Error, "No results were found for your request. #{response.body["error"]}"
      when 429
        raise Error, "Your request exceeded the API rate limit. #{response.body["error"]}"
      when 500
        raise Error, "We were unable to perform the request due to server-side problems. #{response.body["error"]}"
      when 503
        raise Error, "You have been rate limited for sending more than 20 requests per second. #{response.body["error"]}"
      end
      response
    end
  end
end
