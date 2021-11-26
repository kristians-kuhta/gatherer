class Task
  def initialize
    @completed = false
  end

  def completed?
    @completed
  end

  def mark_as_completed
    @completed = true
  end
end
