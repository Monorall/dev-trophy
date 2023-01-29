class ProjectsController < ApplicationController
  before_action :set_project, only: :show

  # GET /projects/1 or /projects/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :ecosystem_id)
    end
end
