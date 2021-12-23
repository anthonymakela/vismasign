# frozen_string_literal: true

require_relative "vismasign/version"

module Vismasign
  autoload :Client, "vismasign/client"
  autoload :Error, "vismasign/error"
  autoload :Object, "vismasign/object"
  autoload :Resource, "vismasign/resource"

  autoload :Document, "vismasign/objects/document"
  autoload :Invitation, "vismasign/objects/invitation"

  autoload :DocumentResource, "vismasign/resources/document"
  autoload :InvitationResource, "vismasign/resources/invitation"
end
