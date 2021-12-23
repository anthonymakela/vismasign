module Vismasign
  class InvitationResource < Resource
    def status(invitation_id:)
      Invitation.new get_request("/api/v1/invitation/#{invitation_id}").body
    end
  end
end
