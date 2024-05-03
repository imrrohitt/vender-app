module RackSessionsFix
  extend ActiveSupport::Concern

  # Define a FakeRackSession class extending Hash
  class FakeRackSession < Hash
    def enabled?
      false
    end

    def destroy
      # Method to destroy the fake session
    end
  end

  included do
    # Run set_fake_session before any action
    before_action :set_fake_session

    private

    # Method to set fake session
    def set_fake_session
      # Initialize a fake session if not already present
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end
