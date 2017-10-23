class User::GenerateAvatarService
  attr_reader :name
  COLORS = %w[#00bcd4 #009688 #e91e63 #4caf50 #607d8b #b94824 #00bcd4].freeze

  def initialize name
    @name = name
  end

  def perform
    file = Tempfile.new([name, '.png'])
    file.binmode
    file.write(Avatarly.generate_avatar(name, size: 200, lang: :ru, vertical_offset: -7, background_color: COLORS.sample))
    file.read
    begin
      File.open(file.path)
    ensure
      file.close
      file.unlink
    end
  end
end
