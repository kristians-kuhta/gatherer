require 'rails_helper'

RSpec.describe CreatesProject, :aggregate_failures do
  describe 'initialization' do
    it 'creates a project given a name and a due date' do
      due_date = 1.month.from_now.to_date
      creator = described_class.new(due_date: due_date, name: 'Project Runway')
      creator.build
      expect(creator.project.name).to eq('Project Runway')
      expect(creator.project.due_date).to eq(due_date)
    end
  end

  describe 'task string parsing' do
    it 'handles an empty string' do
      creator = described_class.new(due_date: 1.month.from_now, name: 'Project Runway', task_string: '')
      tasks = creator.convert_string_to_tasks
      expect(tasks).to be_empty
    end

    it 'handles a single string' do
      creator = described_class.new(due_date: 1.month.from_now, name: 'Project Runway', task_string: 'Start things')
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start things', size: 1)
    end

    it 'handles a single task with size' do
      creator = described_class.new(due_date: 1.month.from_now, name: 'Project Runway', task_string: 'Start things:2')
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start things', size: 2)
    end

    it 'handles a single task with size zero' do
      creator = described_class.new(due_date: 1.month.from_now, name: 'Project Runway', task_string: 'Start things:0')
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start things', size: 1)
    end

    it 'handles a single task with malformed size' do
      creator = described_class.new(due_date: 1.month.from_now, name: 'Project Runway', task_string: 'Start things:a')
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start things', size: 1)
    end

    it 'handles a single task with negative size' do
      creator = described_class.new(due_date: 1.month.from_now, name: 'Project Runway', task_string: 'Start things:-3')
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start things', size: 1)
    end

    it 'handles multiple tasks' do
      creator = described_class.new(
        due_date: 1.month.from_now,
        name: 'Project Runway',
        task_string: "Start things:2\nFinish things:5"
      )
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(2)
      expect(tasks).to match(
        [
          an_object_having_attributes(title: 'Start things', size: 2),
          an_object_having_attributes(title: 'Finish things', size: 5)
        ]
      )
    end

    it 'attaches tasks to the project' do
      creator = described_class.new(
        due_date: 1.month.from_now,
        name: 'Project Runway',
        task_string: "Start things:2\nFinish things:5"
      )
      creator.create
      expect(creator.project.tasks.size).to eq(2)
      expect(creator.project).not_to be_an_new_record
    end
  end
end
