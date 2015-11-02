require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { FactoryGirl.build(:task) }
  let(:complete_task) { FactoryGirl.build(:complete_task) }
  let(:invalid_task) { FactoryGirl.build(:invalid_task) }

  it "allows stubbing" do #just for testing purposes
    faketask = double(Task.new)
    allow(faketask).to receive(:name).and_return("test task")
    expect(faketask.name).to eq("test task")
  end

  context "with a valid task" do
    it "has a valid factory" do
      expect(task).to be_valid
    end

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.not_to validate_presence_of(:description) }

    it { is_expected.not_to validate_presence_of(:done) }

    it { is_expected.not_to validate_presence_of(:project_id) }

    it { is_expected.to belong_to(:project) }

    it "is not marked done" do
      expect(task.done).to be false
    end

  end #valid context

  context "with invalid task" do
    it "has an invalid vactory" do
      expect(invalid_task).to be_invalid
    end

    it "has a nil name" do
      expect(invalid_task.name).to be nil
    end
  end #invalid context

  context "with a complete task" do
    it "is complete" do
      expect(complete_task.done).to be true
    end
  end #complete task context
end
