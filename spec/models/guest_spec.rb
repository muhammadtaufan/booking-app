require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'validate' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  it { should validate_uniqueness_of(:email) }
end
