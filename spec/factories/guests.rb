FactoryBot.define do
  factory :guest do
    firstname { 'John' }
    lastname { 'Doe' }
    phone { '08111111' }
    email { 'john@doe.com' }
  end
end
