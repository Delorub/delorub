FactoryGirl.define do
  sequence :password do |n|
    "aaBBcc#{n.to_s.last(2)}$"
  end
end
