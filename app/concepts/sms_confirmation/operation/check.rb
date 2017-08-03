module SmsConfirmation::Operation
  class Check < Trailblazer::Operation
    step :model!
    step :check_code!

    def model! options, params:, **_
      options['model'] = SmsConfirmation.find_by token: params[:token]
    end

    def check_code! options, params:, model:, **_
      if params['code'] == model.code
        model.accepted = true
        model.save!
      else
        model.increment :attempts
        model.save!
        false
      end
    end
  end
end
