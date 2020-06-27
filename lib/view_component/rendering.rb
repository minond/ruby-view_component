module ViewComponent::Rendering
  # @param [Class] klass, defaults to lookup by controller + action
  # @param [Hash] args
  def component(klass = nil, **args)
    klass ||= "#{controller_path.classify}::#{action_name.classify}".constantize
    render :html => klass.render(args),
           :layout => "layouts/application"
  end
end
