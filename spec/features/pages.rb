feature 'Custom pages' do
  scenario 'check rules page', js: true do
    custom_page = create :page_rules

    visit '/'

    click_link 'Пользовательское соглашение'

    expect(current_path).to eq '/rules'
    expect(page).to have_content custom_page.content
  end
end
