module ApplicationHelper
  def connect_path(auth_provider, opts = {})
    "/auth/#{auth_provider}".tap do |res|
      opts_query = opts.to_query
      res << "?#{opts_query}" if opts_query.present?
    end
  end
end
