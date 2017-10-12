class Roistat::BaseService
  attr_reader :user, :model, :params

  def initialize user:, roistat_visit:, model: nil
    @user = user
    @model = model
    @params = {
      'roistat' => roistat_visit,
      'key'     => Figaro.env.roistat_apy_key,
      'name'    => user.decorate.name,
      'email'   => user.email,
      'phone'   => user.phone,
      'sync'    => '1'
    }
  end

  protected

    def send_to_url params
      Net::HTTP.get_response(URI.parse('https://cloud.roistat.com/api/proxy/1.0/leads/add?' + params))
    end
end
