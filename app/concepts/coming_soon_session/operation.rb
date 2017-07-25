class ComingSoonSession::Create < Trailblazer::Operation
  class Form < Reform::Form
    property :email
    validates :email, presence: true, email: true
  end

  class Present < Trailblazer::Operation
    step Model(ComingSoonSession, :new)
    step Contract::Build(constant: Form)
  end

  step Nested(Present)
  step :assign_request!
  step :assign_session!
  step Contract::Validate()
  step Contract::Persist()

  def assign_request! options
    options['model'].ip = options[:request].ip
    options['model'].city = Ipgeobase.lookup(options[:request].ip).city
    true
  end

  def assign_session! options
    options['model'].referer = options[:session]['referer']
    options['model'].visited_at = options[:session]['visited_at']
    true
  end
end
