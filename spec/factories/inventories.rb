# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inventory do
    name "MyString"
    damaged false
    warehouse nil
  end
end
