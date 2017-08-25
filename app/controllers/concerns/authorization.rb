module Authorization
  private

    def sign_in resource_or_scope, *args
      args.extract_options!
      resource = args.last || resource_or_scope
      super
      cookies[:access_token] = resource.access_token
    end
end
