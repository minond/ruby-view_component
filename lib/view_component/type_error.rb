class ViewComponent::TypeError < ArgumentError
  # @param [Class] component
  # @param [Symbol] prop
  # @param [Class] type
  # @param [Object] val
  def initialize(component, prop, type, val)
    super("#{component} expected :#{prop} to be of type `#{type}` but got `#{val.class}` instead")
  end
end
