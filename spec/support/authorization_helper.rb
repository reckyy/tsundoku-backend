# frozen_string_literal: true

module AuthorizationHelper
  def authorization_stub
    allow_any_instance_of(ApplicationController).to receive(:authenticate).and_return(current_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
  end
end
