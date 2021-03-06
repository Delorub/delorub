feature 'User signs in and signs out' do
  scenario 'with correct details', js: true do
    create(:user, email: 'someone@example.tld', phone: '+79991234567', password: 'somepassword')

    visit '/'

    click_link 'header_sign_in'
    expect(page).to have_css('div', text: 'Войти')
    expect(current_path).to eq(new_user_session_path)

    login 'someone@example.tld', 'somepassword'

    expect(current_path).to eq my_index_index_path
    expect(page).not_to have_css('#header_sign_in')

    find('.dr-authorized-user__name a').hover
    click_link 'user_menu_sign_out'

    expect(current_path).to eq '/'
    expect(page).to have_css('#header_sign_in')

    click_link 'header_sign_in'
    login '+79991234567', 'somepassword'

    expect(current_path).to eq my_index_index_path
    expect(page).not_to have_css('#header_sign_in')
  end

  scenario 'with incorrect details', js: true do
    create(:user, email: 'someone@example.tld', password: 'somepassword')

    visit new_user_session_path

    login 'someone@example.tld', 'wrongpassword'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_css('#header_sign_in')
  end

  private

    def login email, password
      fill_in 'user_email_or_phone', with: email
      fill_in 'user_password', with: password
      click_button 'Войти'
    end
end
