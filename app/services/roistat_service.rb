class RoistatService
  attr_reader :model, :params

  def initialize model:, roistat_visit:
    @model = model
    @params = {
      'roistat' => roistat_visit,
      'key'     => Figaro.env.roistat_apy_key,
      'name'    => model.user.decorate.name,
      'email'   => model.user.email,
      'phone'   => model.user.phone,
      'sync'    => '1'
    }
  end

  def perform_create_delocoin_buy
    send_to_url(params.merge(
      'title' => Figaro.env.roistat_create_delocoin_buy_title,
      'fields' => {
        'status_id' => Figaro.env.roistat_create_delocoin_buy_status_id,
        Figaro.env.roistat_delocoin_buy_field_cost_id => model.cost
      }
    ).to_query)
  end

  def perform_finish_delocoin_buy
    send_to_url(params.merge(
      'title' => Figaro.env.roistat_finish_delocoin_buy_title,
      'fields' => {
        'status_id' => Figaro.env.roistat_finish_delocoin_buy_status_id,
        Figaro.env.roistat_delocoin_buy_field_cost_id => model.cost,
        'price' => model.cost
      }
    ).to_query)
  end

  private

    def send_to_url params
      Net::HTTP.get_response(URI.parse('https://cloud.roistat.com/api/proxy/1.0/leads/add?' + params))
    end
end
