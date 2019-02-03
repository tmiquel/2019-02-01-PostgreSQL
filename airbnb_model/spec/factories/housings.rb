FactoryBot.define do
  factory :housing do
    available_beds { 1 }
    nuity_price { 1 }
    description { 'MyText' }
    has_wifi { false }
    welcome_message { 'MyText' }
  end
end
