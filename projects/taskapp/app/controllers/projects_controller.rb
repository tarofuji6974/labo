class ProjectsController < ApplicationController
  
  # index
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  # タスク追加処理。作成後はindex画面に遷移
  def create
    @project = Project.new(project_params)

    # コミット成功時と失敗時（タイトル未設定）の処理分け
    if @project.save
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  #更新処理
  def update
    @project = Project.find(params[:id])

    #更新成功時と失敗時の処理分け
    if @project.update(project_params)
      redirect_to projects_path
    else
      render 'edit'
    end
  end
  private
    def project_params
      params[:project].permit(:title)
    end
end
