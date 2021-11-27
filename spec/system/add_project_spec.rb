require 'rails_helper'

RSpec.describe 'Adding a project', type: :system do
  it 'allows a user to create a project with tasks' do
    visit new_project_path

    fill_in 'Name', with: 'Project Runway'
    fill_in 'Due date', with: 1.month.from_now.strftime('%d/%m/%Y')
    fill_in 'Tasks', with: "Choose Fabric:3\nMake it work:5"
    click_on 'Create Project'
    visit projects_path

    expect(page).to have_content('Project Runway')
    expect(page).to have_content(8)
  end
end
