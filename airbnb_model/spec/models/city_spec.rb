require 'rails_helper'

RSpec.describe City, type: :model do
  before(:each) do
    @city = FactoryBot.create(:city)
  end

  it 'has a valid factory' do
    # teste toujours tes factories pour voir si elles sont valides
    expect(build(:city)).to be_valid
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(@city).to be_a(City)
    end

    # describe "#city_name" do
    #   it { expect(@city).to validate_presence_of(:city_name) }
    #   it { expect(@city).to validate_uniqueness_of(:city_name).case_insensitive }
    # end

    describe '#zip_code' do
      it { expect(@city).to validate_presence_of(:zip_code) }
      it { expect(@city).to validate_uniqueness_of(:zip_code).case_insensitive }
      it { should allow_value('13001').for(:zip_code) }
      it { should allow_value('2a001').for(:zip_code) }
      it { should_not allow_value('68901 - 68902').for(:zip_code) }
    end
  end

  context 'associations' do
    describe 'housings' do
      it { expect(@city).to have_many(:housings) }
    end

    describe 'bookings' do
      it { expect(@city).to have_many(:bookings) }
    end
  end
end

#     RSpec.describe UserProfile, type: :model do
#       it { should allow_value('http://foo.com').for(:website_url) }
#       it { should allow_value('http://bar.com').for(:website_url) }
#     end
