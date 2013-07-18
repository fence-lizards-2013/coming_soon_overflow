require 'spec_helper'

describe User do
  let(:user) {FactoryGirl.build(:user)}
  subject { user }
  it { should have_many(:posts) }
  it { should have_many(:votes) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }
end
