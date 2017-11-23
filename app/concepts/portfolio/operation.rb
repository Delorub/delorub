module Portfolio::Operation
  class Base < Trailblazer::Operation
    def recreate_cover! options, model:, **_
      model.cover.recreate_versions! if model.cover.present?
    end

    def destroy_temporary_cover! options, model:, params:, **_
      return if options['contract.default'].temporary_cover.model.new_record?
      options['contract.default'].temporary_cover.model.destroy
    end
  end

  class Create < Base
    class Present < Trailblazer::Operation
      step Model(Portfolio, :new)
      step Contract::Build(constant: ::Portfolio::Contract)
      step :prepopulate!

      def prepopulate! options, params:, **_
        options['contract.default'].prepopulate!
      end
    end

    step Nested(Present)
    step Policy::Pundit(PortfolioPolicy, :create?)
    step Contract::Validate()
    step Contract::Persist()

    success :recreate_cover!
    success :destroy_temporary_cover!
  end

  class Update < Base
    class Present < Trailblazer::Operation
      step Model(Portfolio, :find_by)
      step Contract::Build(constant: ::Portfolio::Contract)
      step :prepopulate!

      def prepopulate! options, params:, **_
        options['contract.default'].prepopulate!
      end
    end

    step Nested(Present)
    step Policy::Pundit(PortfolioPolicy, :update?)
    step Contract::Validate()
    step Contract::Persist()

    success :recreate_cover!
    success :destroy_temporary_cover!
  end
end
