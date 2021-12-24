module Vismasign
  class DocumentResource < Resource
    # Returns the headers of the Faraday request containing the location attribute
    def create(**attributes)
      Document.new authorized_post_request("/api/v1/document/", body: attributes).headers
    end

    def add_file(document_id:, file_url:)
      response = get_request(file_url)      
      authorized_post_request("/api/v1/document/#{document_id}/files", content_type: "pdf", body: response.body)
    end

    def retrieve(document_id:)
      Document.new authorized_get_request("/api/v1/document/#{document_id}").body
    end

    # Returns a the status of the document as a String
    def status(document_id:)
      authorized_get_request("/api/v1/document/#{document_id}").body.dig("status")
    end
  end
end
