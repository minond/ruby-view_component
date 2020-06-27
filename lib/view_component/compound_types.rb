module ViewComponent::CompoundTypes
  # rubocop:disable Naming/ConstantName
  Boolean = [FalseClass, TrueClass].freeze
  MaybeBoolean = [NilClass, FalseClass, TrueClass].freeze
  MaybeHash = [NilClass, Hash].freeze
  MaybeString = [NilClass, String].freeze
  # rubocop:enable Naming/ConstantName
end
