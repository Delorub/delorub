class User::Operation::Edit
  class User < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: ::User::Contract::Edit::User)
      step :prepopulate!

      def model! options, params:, **_
        options['model'] = options['current_user']
      end

      def prepopulate! options, params:, **_
        options['contract.default'].prepopulate!
      end
    end

    step Nested(Present)
    step Contract::Validate()
    step Contract::Persist()
  end

  class Master < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: ::User::Contract::Edit::Master)
      step :prepopulate!

      def model! options, params:, **_
        options['model'] = options['current_user']
      end

      def prepopulate! options, params:, **_
        options['contract.default'].prepopulate!
      end
    end

    step Nested(Present)
    step Contract::Validate()
    step Contract::Persist()
  end
end
