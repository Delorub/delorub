# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  title          :string
#  parent_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  lft            :integer
#  rgt            :integer
#  depth          :integer
#  children_count :integer
#  photo          :string
#  position       :integer
#  slug           :string
#  settings       :text
#  description    :text
#  is_main        :boolean          default(FALSE)
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#

describe Category do
  let(:category) { build :category }
  subject { category }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
