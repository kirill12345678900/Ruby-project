FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    encrypted_password { 'password' }
  end
end

