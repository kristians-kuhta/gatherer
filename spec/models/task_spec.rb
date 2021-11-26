require 'rails_helper'

RSpec.describe Task do
  let(:task) { Task.new }

  it 'does not have new task as completed' do
    expect(task).not_to be_completed
  end

  it 'allows to complete a task' do
    task.mark_as_completed
    expect(task).to be_completed
  end
end
