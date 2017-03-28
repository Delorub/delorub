class ContractData
  attr_accessor :answers, :variables

  def initialize answers: []
    @answers = answers
  end

  def to_redux
    {
      answers: {
        0 => 0,
        1 => 1
      },
      variables: {
        1 => {
          value: 'asdasd',
          focused: false
        },
        2 => {
          value: '3123',
          focused: false
        },
        3 => {
          value: '444',
          focused: false
        },
        4 => {
          value: 'asd55asd',
          focused: false
        }
      }
    }
  end
end
