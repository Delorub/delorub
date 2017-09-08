class User::Operation::Update
  class User < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: ::User::Contract::Update::User)
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
    step :update_photo!

    def update_photo! options, model:, params:, **_
      model.photo = options['contract.default'].temporary_photo.model.photo
      model.save
    end
  end

  class Master < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: ::User::Contract::Update::Master)
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
    step :update_photo!

    def update_photo! options, model:, params:, **_
      model.photo = options['contract.default'].temporary_photo.model.photo
      model.save
    end
  end
end
