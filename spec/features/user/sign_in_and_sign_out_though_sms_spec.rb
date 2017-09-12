feature 'User signs in and signs out using sms authentification' do
  scenario 'with correct details', js: true do
    create(:user, email: 'someone@example.tld', phone: '+7 999 123 45 67', password: 'somepassword')
    visit new_user_session_path
    login '+7 999 123 45 67'

    expect(current_path).to eq my_index_index_path
    expect(page).not_to have_css('#header_sign_in')

    find('.dr-authorized-user__name a').hover
    click_link 'user_menu_sign_out'

    expect(current_path).to eq '/'
    expect(page).to have_css('#header_sign_in')
  end

  scenario 'with incorrect phone', js: true do
    create(:user, email: 'someone@example.tld', phone: '+7 999 123 45 67', password: 'somepassword')
    visit new_user_session_path
    login '+7 999 111 11 11'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_css('#header_sign_in')
  end

  scenario 'with incorrect code', js: true do
    create(:user, email: 'someone@example.tld', phone: '+7 999 123 45 67', password: 'somepassword')
    visit new_user_session_path

    fill_in 'user_email_or_phone', with: '+7 999 123 45 67'
    click_link 'sign_in_by_sms'
    expect(page).to have_css('#sms_confirmation_code')

    fill_in 'sms_confirmation_code', with: 'FAIL'
    click_button 'Войти'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_css('#header_sign_in')
  end

  private

    def login phone
      fill_in 'user_email_or_phone', with: phone
      click_link 'sign_in_by_sms'
      expect(page).to have_css('#sms_confirmation_code')

      fill_in 'sms_confirmation_code', with: sms_confirm_code_for(phone)
      click_button 'Войти'
    end

    def sms_confirm_code_for phone
      SmsConfirmation.last.code
    end
end
