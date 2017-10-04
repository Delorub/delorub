class User::GenerateAvatarService
  attr_reader :name
  COLORS = %w[00bcd4 009688 e91e63 4caf50 607d8b b94824 00bcd4].freeze

  def initialize name
    @name = name
  end

  def perform
    Dragonfly.app.generate(:initial_avatar, name.first, background_color: COLORS.sample)
  end
end
