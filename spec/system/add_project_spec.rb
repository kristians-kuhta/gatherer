require 'rails_helper'

RSpec.describe 'Adding a project', type: :system do
  it 'allows a user to create a project with tasks' do
    visit new_project_path

    fill_in 'Name', with: 'Project Runway'
    fill_in 'Due date', with: 1.month.from_now.strftime('%d/%m/%Y')
    fill_in 'Tasks', with: "Choose Fabric:3\nMake it work:5"
    click_on 'Create Project'

    project = Project.find_by(name: 'Project Runway')
    project_dom_id = "#project_#{project.id}"
    project_name_dom_id = "#{project_dom_id}_name"
    project_total_size_dom_id = "#{project_dom_id}_total_size"
    expect(page).to have_selector("#{project_dom_id} #{project_name_dom_id}", text: 'Project Runway')
    expect(page).to have_selector("#{project_dom_id} #{project_total_size_dom_id}", text: '8')
  end

  it 'does not allow not allow a user to create a project without a name and due date' do
    visit new_project_path

    fill_in 'Name', with: ''
    fill_in 'Due date', with: ''
    fill_in 'Tasks', with: "Choose Fabric:3\nMake it work:5"
    click_on 'Create Project'
    expect(page).to have_selector('#new_project')
  end
end
