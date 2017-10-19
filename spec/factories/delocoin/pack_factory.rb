# == Schema Information
#
# Table name: delocoin_packs
#
#  id        :integer          not null, primary key
#  cost      :integer
#  discount  :float
#  number    :integer
#  is_public :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :delocoin_pack, class: Delocoin::Pack do
    cost 500
    discount 1.0
  end
end
