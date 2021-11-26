require 'rails_helper'

RSpec.describe Project do
  let(:project) { Project.new }
  let(:task) { Task.new }

  describe 'completion' do
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

  describe 'estimates' do
    let(:project) { Project.new }
    let(:done) { Task.new(size: 2, completed_at: Time.current) }
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }

    before(:example) do
      project.tasks = [done, small_not_done, large_not_done]
    end

    it 'can calculate total size' do
      expect(project.total_size).to eq(7)
    end
    it 'can calculate remaining size' do
      expect(project.remaining_size).to eq(5)
    end
  end
end
