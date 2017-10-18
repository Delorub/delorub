feature 'Main page' do
  scenario 'should be valid', js: true do
    visit '/'
  end

  scenario 'should have legal links', js: true do
    visit '/'

    expect(find_link('Пользовательское соглашение')[:href]).to eq '/rules'
    expect(find_link('Конфиденциальность')[:href]).to eq '/conf'
    expect(find_link('Регламент оборота монет')[:href]).to eq '/reglament'
    expect(find_link('Оферта')[:href]).to eq '/oferta'
  end
end
