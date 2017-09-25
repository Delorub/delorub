include Warden::Test::Helpers
feature 'Billing yandex kassa deposit' do
  before(:each) do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
  end

  scenario 'with correct details', js: true do
    visit my_billing_index_path
    expect(current_path).to eq my_billing_index_path
    expect(page).to have_css('#new_billing_yandex_kassa_deposit')

    fill_form(100, true)
    click_button 'Продолжить'

    expect(current_path).to eq confirm_my_billing_path(Billing::YandexKassa::Deposit.last.uuid.to_s)
  end

  scenario 'with incorrect details', js: true do
    visit my_billing_index_path
    expect(current_path).to eq my_billing_index_path
    expect(page).to have_css('#new_billing_yandex_kassa_deposit')

    fill_form('test', false)
    click_button 'Продолжить'

    expect(current_path).to eq my_billing_index_path
  end

  private

    def fill_form amount, check = false
      fill_in 'billing_yandex_kassa_deposit_amount', with: amount
      find('.checkbox-custom').click if check
    end
end
