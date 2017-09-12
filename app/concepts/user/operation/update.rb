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
    success :recreate_versions!
    success :destroy_temporary_photo!

    def recreate_versions! options, model:, params:, **_
      model.photo.recreate_versions! if model.photo.present?
    end

    def destroy_temporary_photo! options, model:, params:, **_
      return if options['contract.default'].temporary_photo.model.new_record?
      options['contract.default'].temporary_photo.model.destroy
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
    success :recreate_versions!
    success :destroy_temporary_photo!

    def recreate_versions! options, model:, params:, **_
      model.photo.recreate_versions! if model.photo.present?
    end

    def destroy_temporary_photo! options, model:, params:, **_
      return if options['contract.default'].temporary_photo.model.new_record?
      options['contract.default'].temporary_photo.model.destroy
    end
  end
end
