require 'rails_helper'

feature "CRUD methods for tasks" do

  it "Allows users to sign up and create a task" do

    sign_up_with("tacotuesday@aol.com", "password")

    click_link "Tasks"
    click_link "New Task"
    fill_in 'Name', with: 'Looming task'
    expect { click_button 'Create Task' }.to change(Task, :count).by(1)
    #user clicks Create Task button
    #task is successfully saved
  end

  it "Allows users to edit tasks" do

    sign_in_user

    click_link "Tasks"
    click_link "New Task"
    fill_in 'Name', with: 'Looming task'
    click_button 'Create Task'

    expect(page).to have_content("Looming task")

    click_link "Edit"
    fill_in 'Name', with: 'Updated looming task'
    click_button "Update Task"

    expect(page).to have_content("successfully updated")


  end

end #allows creating a new task
