require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    @class_name.constantize
  end

  def table_name
    # ...
    "#{@class_name.underscore}s"
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    @class_name = options[:class_name] || name.to_s.capitalize.singularize
    @foreign_key = options[:foreign_key] || "#{@class_name.underscore}_id".to_sym
    @primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    @class_name = options[:class_name] || name.to_s.capitalize.singularize
    @foreign_key = options[:foreign_key] || "#{self_class_name.underscore}_id".to_sym
    @primary_key = options[:primary_key] || :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    obj = BelongsToOptions(name, options)
    define_method(name) do
      foreign = self.send(obj.foreign_key)
    end
    call the query

  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...

end
