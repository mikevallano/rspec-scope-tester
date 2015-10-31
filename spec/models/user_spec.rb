require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }
  let(:invalid_user) { FactoryGirl.build(:invalid_user) }

  context "with a valid user" do
    it "is a valid factory" do
      expect(user).to be_valid
    end

    it {is_expected.to have_many(:projects)}
  end #valid user context

  context "with an invalid user" do
    it "is an invalid factory" do
      expect(invalid_user).to be_invalid
    end
  end #invalid user context
end
