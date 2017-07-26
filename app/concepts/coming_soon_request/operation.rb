class ComingSoonRequest::Create < Trailblazer::Operation
  class Form < Reform::Form
    property :email
    validates :email, presence: true, email: true
  end

  class Present < Trailblazer::Operation
    step Model(ComingSoonRequest, :new)
    step Contract::Build(constant: Form)
  end

  step Nested(Present)
  step :assign_visitor_session!
  step Contract::Validate()
  step Contract::Persist()

  def assign_visitor_session! options
    unless options[:visitor_session].nil?
      options['model'].visitor_session = options[:visitor_session].model
    end
    true
  end
end
