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

  scenario 'it assigns created project to the current user' do
    sign_up_with("taco@aol.com", "password")

    click_link 'Projects'
    click_link 'New Project'
    fill_in 'Name', with: 'zorro'
    click_button "Create Project"

    click_link 'Projects'

    expect(page).to have_content('zorro')

  end #assigns project to current user

  scenario 'user only sees projects that belong to him on index page' do
    FactoryGirl.create(:project, name: "not my project")

    sign_up_with("tacoman@aol.com", "password")

    create_project

    click_link 'Projects'

    expect(current_path).to eq(projects_path)

    expect(page).not_to have_content "not my project"

  end #index page

  scenario "can't view another user's project" do

    not_my_project = FactoryGirl.create(:project, name: "not my project")

    sign_up_with("tacoman@aol.com", "password")

    visit project_path(not_my_project)

    expect(page).to have_content "You can't muck with another user's project."

  end #show page

  scenario "can't edit another user's project" do

    not_my_project = FactoryGirl.create(:project, name: "not my project")

    sign_up_with("tacoman@aol.com", "password")

    visit edit_project_path(not_my_project)

    expect(page).to have_content "You can't muck with another user's project."

  end #edit page

  scenario "can't edit another user's project" do

    not_my_project = FactoryGirl.create(:project, name: "not my project")

    sign_up_with("tacoman@aol.com", "password")

    page.driver.submit :patch, "/projects/#{not_my_project.id}", {"project"=>{"name"=>"new name"}}

    expect(page).to have_content "You can't muck with another user's project."

  end #update action

  scenario "can't delete another user's project" do

    not_my_project = FactoryGirl.create(:project, name: "not my project")

    sign_up_with("tacoman@aol.com", "password")

    expect{page.driver.submit :delete, "/projects/#{not_my_project.id}", {}}.to change(Project, :count).by(0)

    expect(page).to have_content "You can't muck with another user's project."

  end #delete action


end #end of feature spec