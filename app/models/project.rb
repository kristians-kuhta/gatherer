class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :due_date, presence: true

  def self.velocity_length_in_days
    21
  end

  def done?
    incomplete_tasks.empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    incomplete_tasks.sum(&:size)
  end

  def completed_velocity
    tasks.select(&:part_of_velocity?).sum(&:points_toward_velocity)
  end

  def current_rate
    completed_velocity * 1.0/self.class.velocity_length_in_days
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    return false if projected_days_remaining.nan?

    Time.current + projected_days_remaining.days < due_date
  end

  private

  def incomplete_tasks
    tasks.reject(&:completed?)
  end
end

