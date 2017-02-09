module ActiveAdmin::LinkHelper
  def namespaced_path name, *args
    send(name.gsub(/namespace/, current_namespace.to_s), *args)
  end
  
  def current_namespace
    self.active_admin_namespace.name
  end
end
