class Roistat
  include Users
  include DelocoinBuy

  attr_reader :visitor_id, :user

  def initialize user, visitor_id
    @visitor_id = visitor_id
    @user = user
  end

  def push_async method, payload = nil
    RoistatWorker.perform_async method, user.id, visitor_id, payload
  end

  def push method, payload
    make_push send(method, payload)
  end

  private

    def make_push params
      Net::HTTP.get_response(URI.parse('https://cloud.roistat.com/api/proxy/1.0/leads/add?' + {
        'roistat' => visitor_id,
        'key'     => Figaro.env.roistat_apy_key,
        'name'    => user.decorate.name,
        'email'   => user.email,
        'phone'   => user.phone,
        'sync'    => '1'
      }.merge(params).to_query))
    end
end
