require "time"
require "digest/md5"
require "base64"
require "json"

module Vismasign
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def authorized_get_request(url, params: {}, headers: {})      
      handle_response client.connection.get(url, params, authorization_header(url, "GET").merge(headers))
    end

    def authorized_post_request(url, content_type: "json", body:, headers: {})
      if content_type.eql?("json")
        handle_response client.connection.post(url, body, authorization_header(url, "POST", payload: body.to_json, content_type: content_type).merge(headers))
      else
        handle_response client.connection.post(url, body, authorization_header(url, "POST", payload: body, content_type: content_type).merge(headers))
      end      
    end

    def get_request(url, params: {}, headers: {})      
      handle_response client.connection.get(url, params, headers)
    end

    def authorization_header(path, http_verb, payload: "", content_type: "json")
      date = Time.now.rfc2822
      if content_type.eql?("json")
        md5_file = Digest::MD5.digest(payload.encode)
      else
        md5_file = Digest::MD5.digest(payload)
      end
      content_md5 = Base64.strict_encode64(md5_file)
      digest = OpenSSL::Digest.new("sha512")
      key = Base64.decode64(client.api_key)
      authorization_header = [http_verb, content_md5, "application/#{content_type}", date, path].join("\n")
      authorization_header_enc = "Onnistuu " + client.identifier + ":" + Base64.strict_encode64(OpenSSL::HMAC.digest(digest, key, authorization_header.encode))
      {"Content-MD5": content_md5, "Content-Type": "application/#{content_type}", Date: date, Authorization: authorization_header_enc}
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Your request was malformed. #{response.body["error"]}, #{response.body["validation_errors"]}"
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
