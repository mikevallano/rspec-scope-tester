require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { FactoryGirl.build(:project) }
  let(:invalid_project) { FactoryGirl.build(:invalid_project) }

  it "Project responds to #by_user" do
      expect(Project).to respond_to(:by_user)
    end

  context "with valid project" do
    it "is a valid factory" do
      expect(project).to be_valid
    end

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.not_to validate_presence_of(:description) }

    it { is_expected.not_to validate_presence_of(:notes) }

    it { is_expected.to respond_to(:name) }

    it {is_expected.to belong_to(:user)}

    it "has a user" do
      expect(project.user_id.present?).to be true
    end

  end #valid project context

  context "with an invalid project" do
    it "is an invalid project" do
      expect(invalid_project).to be_invalid
    end

    it "has a nil name" do
      expect(invalid_project.name).to eq(nil)
    end
  end #invalid project context
end
