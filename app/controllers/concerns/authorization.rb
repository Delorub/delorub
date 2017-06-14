module Authorization
  private

  def create_after_authorization? type
    return false if session[:after_authorization].nil?
    return false if session[:after_authorization]['type'] != type
    true
  end

  def create_after_authorization_data type
    session[:after_authorization]['data'] if create_after_authorization? type
  end

  def create_after_authorization type, data
    session[:after_authorization] = { type: type, data: data }
  end

  def after_sign_in_path_for(resource)
    if @after_authorization_creator && @after_authorization_creator.path
      return @after_authorization_creator.path
    end
    root_path
  end

  def sign_in resource_or_scope, *args
    if session[:after_authorization] && session[:after_authorization]['data']
      options = args.extract_options!
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      resource = args.last || resource_or_scope

      @after_authorization_creator = AfterAuthorizationCreator.new \
        session[:after_authorization]['type'],
        session[:after_authorization]['data'],
        resource

      @after_authorization_creator.perform
      session[:after_authorization] = nil if @after_authorization_creator.should_clear_session?
    end
    super
  end
end
