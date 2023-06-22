RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:encrypted_password) }
  end

  describe 'associations' do
    it { should have_many(:events) }
  end
end