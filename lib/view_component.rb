require "action_view"
require "active_support"
require "active_support/core_ext/string/output_safety"

require "view_component/version"
require "view_component/compound_types"
require "view_component/type_checker"
require "view_component/type_error"
require "view_component/rendering"
require "view_component/injector"
require "view_component/railtie"

class ViewComponent
  include ViewComponent::CompoundTypes

  # @param [Symbol] tag
  # @param [Hash] attrs
  # @return [Class]
  #
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def self.new(tag, **attrs, &block)
    return super unless self == ViewComponent

    props = attrs.delete(:props) || {}

    Class.new(ViewComponent) do
      props props

      define_method(:_tag) { tag }
      define_method(:_attrs) { attrs }
      define_method(:_block) { block }

      def initialize(children = nil, **attr_overrides)
        super(children, **_attrs.merge(attr_overrides))
      end

      def render
        content_tag(_tag, _attrs.merge(@attributes.slice(*_attrs.keys))) do
          if children_overrides.present?
            children_overrides
          elsif _block.present?
            html(instance_eval(&_block))
          else
            ""
          end
        end
      end

      def children_overrides
        @children_overrides ||= children
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  # @param [Array<String>, String] strs
  # @return [String]
  def self.html(strs)
    strs = strs.join if strs.is_a? Array
    strs&.html_safe || ""
  end

  # @param [Array<String>, String, Nil] children
  # @param [Hash] attrs
  # @return [String]
  def self.render(children = nil, **attrs, &block)
    html(new(children, **attrs, &block).render)
  end

  # @param [Array<Symbol>] props
  # @return [Array<Symbol>]
  def self.props(props = nil)
    return @props || [] if props.nil?

    attr_accessor(*props.keys)
    @props = props
  end

  # @param [Hash] attrs
  # @return [Array<Symbol, Class, Object>]
  def self.zip(attrs)
    props.each_with_object([]) do |(prop, type), acc|
      acc << [prop, type, attrs[prop]]
    end
  end

  # @param [Array<String>, String, Nil] children
  # @param [Hash] attrs
  # @raise [TypeError] if a property is passed in with an unexpected type.
  def initialize(children = nil, **attrs)
    @children = proc { |*args| block_given? ? yield(*args) : children }
    @view_context = attrs.delete(:view_context)
    @attributes = attrs

    self.class.zip(attrs).each do |(prop, type, val)|
      TypeChecker.assert!(prop, type, val)
      send("#{prop}=", val)
    end
  end

  # @return [String, Array<String>]
  def render
    raise NotImplementedError, "#render is not implemented"
  end

private

  attr_accessor :view_context

  # @param [Array<String>, String] strs
  # @return [String]
  def html(strs)
    self.class.html(strs)
  end

  # @param [Array<Object>] args
  # @return [String]
  def children(*args)
    html(@children.call(*args))
  end

  # @param [Symbol] key
  # @param [Hash] args
  # @return [String]
  def t(key, **args)
    I18n.t(key, args)
  end

  # Allows ActionController::RequestForgeryProtection and authenticity token
  # generation to work.
  #
  # @return [Hash]
  def session
    {}
  end

  # Allows for methods like `asset_path` to be called within components.
  def method_missing(method, *args)
    if view_context&.respond_to?(method)
      view_context.send(method, *args)
    else
      super
    end
  end

  def respond_to_missing?(method, *_args)
    view_context&.respond_to?(method)
  end
end
