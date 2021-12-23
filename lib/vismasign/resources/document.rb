module Vismasign
  class DocumentResource < Resource

    # Returns the headers of the Faraday request containing the location attribute
    def create(**attributes)
      Document.new post_request("/api/v1/document/", body: attributes).headers
    end

    def retrieve(document_id:)
      Document.new get_request("/api/v1/document/#{document_id}").body
    end

    # Returns a the status of the document as a String
    def status(document_id:)
      get_request("/api/v1/document/#{document_id}").body.dig("status")
    end

    def add_file(document_id:, payload:)
      Document.new post_request("/api/v1/document/#{document_id}/files", body: payload).body
    end
  end
end
