module ViewComponent::TypeChecker
  # @param [Symbol] val
  # @param [Class] type
  # @param [Object] val
  # @return [Boolean]
  def self.assert!(prop, type, val)
    raise ViewComponent::TypeError.new(name, prop, type, val) unless of_type?(type, val)
  end

  # @param [Class] type
  # @param [Object] val
  # @return [Boolean]
  def self.of_type?(type, val)
    if type.is_a?(Array) && type.size == 1
      of_list_type?(type, val)
    elsif type.is_a? Array
      of_union_type?(type, val)
    else
      val.is_a? type
    end
  end

  # @param [Class] type
  # @param [Object] val
  # @return [Boolean]
  def self.of_list_type?(type, val)
    case val
    when ActiveRecord::AssociationRelation
      val.name == type.first.name
    when Array
      val.first.nil? || val.first.is_a?(type.first)
    else
      false
    end
  end

  # @param [Class] type
  # @param [Object] val
  # @return [Boolean]
  def self.of_union_type?(type, val)
    type.any? { |t| val.is_a? t }
  end
end
