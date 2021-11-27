class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    workflow = CreatesProject.new(
      name: params[:project][:name],
      due_date: params[:project][:due_date],
      task_string: params[:project][:tasks],
    )
    workflow.create

    redirect_to projects_path
  end

  def index
    @projects = Project.all
  end
end
