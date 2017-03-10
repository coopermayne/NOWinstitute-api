if defined?(Spring) && Spring.instance_methods(false).include?(:watch)
  Spring.watch "config/application.yml"
end
