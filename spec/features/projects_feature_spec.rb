require 'rails_helper'

feature "Can sign up and add a new project" do
  scenario "allows a user to create a project" do

    sign_up_with("taco@aol.com", "password")

    # sign_in_user

    click_link 'Projects'
    click_link 'New Project'
    fill_in 'Name', with: 'zorro'
    expect { click_button 'Create Project' }.to change(Project, :count).by(1)

    expect(page).to have_content 'Project was successfully created'

  end #allows creating a project

end #end of feature spec