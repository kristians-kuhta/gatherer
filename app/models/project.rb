class Project
  attr_accessor :tasks
  def initialize
    @tasks = []
  end

  def done?
    tasks.all?(&:completed?)
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    tasks.reject(&:completed?).sum(&:size)
  end
end

