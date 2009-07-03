module HasOverrides::ClassMethods
  def has_overrides
    self.extend(HasOverrides::ClassSingletonMethods)
  end

  private
  def override_module
    begin
      self::Overrides
    rescue
      self.const_set(:Overrides, Module.new)
    end
  end

  def writers_module
      self::OverrideWriters
  rescue
    writers = Module.new
    writers.instance_methods.each do |meth|
      if meth.ends_with?("=")
        attr_name = meth[0..-2]
        if columns_hash[attr_name]
          mirror.send(:define_method, meth) do |v|
            write_attribute(attr_name, v)
          end
        end
      end
    end
    self.const_set(:OverrideWriters, writers)
  end

  def intercept_overridden_attributes(attributes)
    returning({}) do |intercepted|
      attributes.keys.each do |attr|
        if override_module.instance_methods.include?(attr.to_s+"=")
          intercepted[attr] = attributes.delete(attr)
        end
      end
    end
  end
end