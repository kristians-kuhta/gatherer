require 'rails_helper'

RSpec.describe Project do
  let(:project) { Project.new }
  let(:task) { Task.new }

  it 'considers a project with no tasks to be done' do
    expect(project).to be_done
  end

  it 'is not done when there are incomplete tasks' do
    project.tasks << task
    expect(project).not_to be_done
  end

  it 'marks a project as done if all tasks are completed' do
    task.mark_as_completed
    project.tasks << task

    expect(project).to be_done
  end
end
