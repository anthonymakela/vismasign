module Vismasign
  class InvitationResource < Resource
    def create(attributes, document_id:)
      authorized_post_request("/api/v1/document/#{document_id}/invitations", body: attributes).body
    end
  end
end
