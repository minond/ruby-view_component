class ViewComponent
  module Injector
    def self.inject_rails_helpers_into_view_component!
      if defined?(ActionView)
        ViewComponent.include ActionView::Helpers::UrlHelper
        ViewComponent.include ActionView::Helpers::FormHelper
        ViewComponent.include ActionView::Context
      end

      ViewComponent.include Rails.application.routes.url_helpers if defined?(Rails) && Rails.respond_to?(:application)
      ViewComponent.include ActiveSupport::Configurable if defined?(ActiveSupport)
      ViewComponent.include ActionController::RequestForgeryProtection if defined?(ActionController)
    end

    def self.inject_view_component_helpers_into_rails!
      ActionController::Base.include ViewComponent::Rendering if defined?(ActionController)
    end
  end
end
