class ViewComponent
  module Injector
    def self.inject_rails_helpers_into_view_component!
      ViewComponent.include Rails.application.routes.url_helpers if defined?(Rails)
      ViewComponent.include ActionView::Helpers::UrlHelper
      ViewComponent.include ActionView::Helpers::FormHelper
      ViewComponent.include ActionView::Context
      ViewComponent.include ActiveSupport::Configurable
      ViewComponent.include ActionController::RequestForgeryProtection if defined?(ActionController)
    end

    def self.inject_view_component_helpers_into_rails!
      ActionController::Base.include ViewComponent::Rendering
    end
  end
end
