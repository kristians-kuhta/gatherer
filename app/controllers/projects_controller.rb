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

    if workflow.success?
      redirect_to projects_path
    else
      @project = workflow.project
      render :new
    end
  end

  def index
    @projects = Project.all
  end
end
