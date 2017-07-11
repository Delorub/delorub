# == Schema Information
#
# Table name: places
#
#  id                 :integer          not null, primary key
#  fias_aoguid        :string
#  name               :string
#  full_name          :string
#  level              :integer
#  place_type         :integer
#  place_type_name_id :integer
#  parent_place_id    :integer
#  region_place_id    :integer
#  is_region_center   :boolean
#  is_center          :boolean
#  custom             :boolean
#

describe Place do
  let(:place) { build :place }
  subject { place }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:place_type_name) }
    it { is_expected.to belong_to(:parent_place) }
    it { is_expected.to belong_to(:region_place) }
  end
end
