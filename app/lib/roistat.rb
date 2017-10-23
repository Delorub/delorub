class Roistat
  include Roistat::Users
  include Roistat::DelocoinBuy

  attr_reader :visitor_id, :user

  def initialize user, visitor_id
    @visitor_id = visitor_id
    @user = user
  end

  def push_async method, payload = nil
    RoistatWorker.perform_async method, user.id, visitor_id, payload
  end

  def push method, payload
    payload = payload.symbolize_keys unless payload.nil?
    make_push send(method.to_sym, payload)
  end

  private

    def make_push params
      Net::HTTP.get_response(URI.parse(Figaro.env.roistat_url + {
        'roistat' => visitor_id,
        'key'     => Figaro.env.roistat_apy_key,
        'name'    => user.decorate.name,
        'email'   => user.email,
        'phone'   => user.phone,
        'sync'    => '1'
      }.merge(params).to_query))
    end
end
