class User::OnlineService
  MINUTES_ONLINE = 15

  attr_reader :user

  def initialize user
    @user = user
    @redis_value = nil
  end

  def update_online
    write_redis_value Time.new.getutc.to_i
  end

  def online?
    return false if last_action_at.nil?
    difference = Time.new.getutc.to_i - last_action_at
    (difference / 60).to_i <= MINUTES_ONLINE
  end

  def last_action_at
    return if redis_value.nil?
    redis_value.to_i
  end

  private

    def redis_value
      @redis_value ||= Redis.current.get redis_key
    end

    def write_redis_value value
      @redis_value = value
      Redis.current.set redis_key, redis_value
    end

    def redis_key
      "user:#{user.id}:last_action_at"
    end
end
