class ContractTemplate::Markup
  extend JsonSerializable

  attr_accessor :questions, :variables, :text

  def initialize questions: [], variables: [], text: ''
    @questions = questions
    @variables = variables
    @text = ContractTemplate::Text.new(data: text)
  end

  def from_parameters parameters
    @questions = get_questions_from_parameters parameters[:questions]
    @text = ContractTemplate::Text.new(data: parameters[:text])
    self
  end

  def to_redux
    {
      questions: questions,
      text: { data: text.data },
      variables: variables,
    }
  end

  private

    def get_questions_from_parameters parameters
      parameters.map do |id, question|
        ContractTemplate::Question.new(
          id: id,
          title: question[:title],
          variants: get_variants_from_parameters(question[:variants])
        )
      end
    end

    def get_variants_from_parameters parameters
      parameters.map do |id, variant|
        ContractTemplate::Variant.new(
          id: id,
          title: variant[:title]
        )
      end
    end
end
