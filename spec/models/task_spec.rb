require 'rails_helper'

RSpec.describe Task do
  let(:task) { Task.new }

  describe 'completion' do
    it 'does not have new task as completed' do
      expect(task).not_to be_completed
    end

    it 'allows to complete a task' do
      task.mark_as_completed
      expect(task).to be_completed
    end
  end

  describe 'velocity' do
    let(:task) { Task.new(size: 3) }

    it 'does not include incomplete tasks when calculating velocity' do

      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0)
    end

    it 'includes recently completed tasks when calculating velocity' do
      task.mark_as_completed(1.day.ago)

      expect(task).to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(3)
    end

    it 'does not count a task that has been completed long-ago towards velocity' do
      task.mark_as_completed(2.years.ago)

      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0)
    end
  end
end
