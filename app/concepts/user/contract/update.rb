class User::Contract::Update
  class Form < Reform::Form
    property :first_name
    property :middle_name
    property :last_name

    property :photo, parse: false
    property :temporary_photo,
      prepopulator: ->(options) {
        self.temporary_photo = ::User::TemporaryPhoto.new(photo: 'real')
        temporary_photo.user_model = model
      },
      populator: ->(fragment:, **) {
        return if fragment['id'].blank?
        item = ::User::TemporaryPhoto.find_by(id: fragment['id'].to_i)
        self.temporary_photo = item || ::User::TemporaryPhoto.new
        self.photo = File.open(temporary_photo.model.photo.path)
      },
      virtual: true do
      property :id
      property :user_model, parse: false, virtual: true

      def uploaded_or_real_photo
        return user_model.photo if model.photo.blank? && user_model.present?
        model.photo
      end
    end

    validates :first_name, presence: true
  end

  class User < Form; end

  class Master < Form
    property :profile, form: Profile::Contract::Form
  end
end
