class CreatesProject
  attr_reader :project
  def initialize(name: '', due_date:, task_string: '')
    @name = name
    @due_date = due_date
    @task_string = task_string
  end

  def build
    @project = Project.new(name: @name, due_date: @due_date)
    @project.tasks = convert_string_to_tasks
    @project
  end

  def convert_string_to_tasks
    return [] if @task_string.blank?

    tasks = @task_string.split("\n").map { |t| t.split(':') }

    tasks.map do |title, size|
      Task.new(title: title, size: convert_task_size(size))
    end
  end

  def create
    build
    project.save
  end

  private

  def convert_task_size(size)
    return 1 unless /\d+/i.match?(size)

    size_as_number = size.to_i
    return 1 if size_as_number.zero? || size_as_number.negative?

    size_as_number
  end
end
