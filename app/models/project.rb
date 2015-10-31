class Project < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name

  scope :by_user, lambda { |user| where(:user_id => user.id) }
end
