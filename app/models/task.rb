class Task
  attr_reader :size

  def initialize(size: 0, completed: false)
    @completed = completed
    @size = size
  end

  def completed?
    @completed
  end

  def mark_as_completed
    @completed = true
  end
end
