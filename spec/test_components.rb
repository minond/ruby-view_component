TypedComponent = ViewComponent.new(:span, :props => { :s => String, :b => [NilClass, TrueClass, FalseClass] })

VariableComponent = ViewComponent.new(:span, :class => "header", :props => { :label => ViewComponent::MaybeString }) { label || "hi" }

class ClassComponent < ViewComponent
  props :label => MaybeString

  def render
    <<-HTML
      <span>#{label || 'hi'}</span>
    HTML
  end
end
