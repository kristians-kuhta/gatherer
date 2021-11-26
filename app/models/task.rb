class Task
  attr_reader :size

  def initialize(size: 0, completed_at: nil)
    mark_as_completed(completed_at) if completed_at.present?
    @size = size
  end

  def completed?
    @completed_at.present?
  end

  def mark_as_completed(date = Time.current)
    @completed_at = date
  end

  def part_of_velocity?
    return false unless @completed_at.present?

    @completed_at > 21.days.ago
  end

  def points_toward_velocity
    part_of_velocity? ? size : 0
  end
end
