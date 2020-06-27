class ViewComponent
  class Railtie < Rails::Railtie
    initializer "view_component.inject_view_component_helpers_into_rails" do
      ViewComponent::Injector.inject_view_component_helpers_into_rails!
    end

    initializer "view_component.inject_rails_helpers_into_view_component" do
      ViewComponent::Injector.inject_rails_helpers_into_view_component!
    end
  end
end
