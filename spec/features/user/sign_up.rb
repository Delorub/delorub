feature 'User signs up' do
  scenario 'with correct details', js: true do
    visit '/'

    click_link 'header_sign_up'
    expect(page).to have_css('#new_user')
    expect(current_path).to eq(new_user_registration_path)

    register 'Alex', 'someone@example.tld', '+79991234567'

    expect(current_path).to eq my_welcome_index_path
    expect(page).not_to have_css('#header_sign_in')
  end

  private

    def register first_name, email, phone
      fill_in 'user_first_name', with: first_name
      fill_in 'user_email', with: email
      find('.checkbox-custom').click
      fill_and_confirm_phone phone

      find('.registration-form__content-button-submit input').click
    end

    def fill_and_confirm_phone phone
      fill_in 'user_sms_confirmation_attributes_phone', with: phone
      click_button 'sms_send_confirm_phone'
      expect(page).to have_css('#sms_confirm_phone')

      fill_in 'sms_confirmation_code', with: sms_confirm_code_for(phone)
      click_button 'sms_confirm_phone'
      expect(page).to have_css('.form__approved')
    end

    def sms_confirm_code_for phone
      SmsConfirmation.last.code
    end
end
