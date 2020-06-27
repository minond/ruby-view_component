# rubocop:disable Lint/SuppressedException
begin
  require "action_view"
rescue LoadError
end

begin
  require "active_support"
rescue LoadError
end
# rubocop:enable Lint/SuppressedException

class ViewComponent
  include Rails.application.routes.url_helpers if defined?(Rails)
  include ActionView::Helpers::AssetUrlHelper if defined?(ActionView)
  include ActionView::Helpers::UrlHelper if defined?(ActionView)
  include ActionView::Helpers::AssetTagHelper if defined?(ActionView)
  include ActionView::Helpers::FormHelper if defined?(ActionView)
  include ActionView::Context if defined?(ActionView)
  include ActiveSupport::Configurable if defined?(ActiveSupport)
  include ActionController::RequestForgeryProtection if defined?(ActionController)
end
