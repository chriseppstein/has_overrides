module HasOverrides
end

%w(class_methods class_singleton_methods).each do |f|
  require File.join(File.dirname(__FILE__), 'has_overrides', f)
end
