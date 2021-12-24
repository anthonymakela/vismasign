module Vismasign
  class InvitationResource < Resource
    # Returns data related to the created invitation. Should be a collection, but the api doesn't return a key.
    def create(attributes, document_id:)
      Invitation.new authorized_post_request("/api/v1/document/#{document_id}/invitations", body: attributes).body[0]
    end
  end
end
