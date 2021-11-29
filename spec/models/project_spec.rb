require 'rails_helper'

RSpec.describe Project do
  it_should_behave_like 'sizeable'

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
    let(:old_done) { Task.new(size: 3, completed_at: 22.days.ago) }
    let(:new_done) { Task.new(size: 5, completed_at: 2.days.ago) }
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }

    describe 'blank project estimates' do
      it 'handles blank project' do
        expect(project.size).to eq(0)
        expect(project.remaining_size).to eq(0)
        expect(project.completed_velocity).to eq(0)
        expect(project.current_rate).to eq(0)
        expect(project.projected_days_remaining).to be_nan
        expect(project).not_to be_on_schedule
      end
    end

    describe 'project with tasks estimates' do
      before(:example) do
        project.tasks = [done, small_not_done, large_not_done, old_done, new_done]
      end

      it 'can calculate total size' do
        expect(project.size).to eq(15)
      end
      it 'can calculate remaining size' do
        expect(project.remaining_size).to eq(5)
      end

      it 'can calculate completed velocity' do
        expect(project.completed_velocity).to eq(7)
      end

      it "calculates the rate for completed velocity" do
        expect(project.current_rate).to eq(7.0/21)
      end

      it "calculates projected days remaining" do
        expect(project.projected_days_remaining).to eq(15)
      end

      it 'knows if we are on schedule' do
        project.due_date = 3.weeks.from_now
        expect(project).to be_on_schedule
      end

      it 'knows if we are not on schedule' do
        project.due_date = 1.weeks.from_now
        expect(project).not_to be_on_schedule
      end
    end
  end
end
