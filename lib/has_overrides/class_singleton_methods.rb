module HasOverrides::ClassSingletonMethods
  def new(*args)
    attrs = args.last

    overridden = attrs.is_a?(Hash) ? intercept_overridden_attributes(attrs) : {}

    returning(super) do |this|
      this.extend(writers_module)
      this.extend(override_module)

      overridden.each do |attr, val|
        setter = "#{attr}=".to_sym
        this.send(setter, val)
      end
    end
  end

end