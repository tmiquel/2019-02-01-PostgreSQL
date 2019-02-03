FactoryBot.define do
  factory :user do
    first_name { 'MyString' }
    email { 'MyString' }
    phone_number { 'MyString' }
    description { 'MyText' }
  end
end
