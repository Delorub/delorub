class User::Contract::Edit
  class Form < Reform::Form
    property :first_name
    property :middle_name
    property :last_name

    validates :first_name, presence: true
  end

  class User < Form; end

  class Master < Form
    property :profile, form: Profile::Contract::Form
  end
end
