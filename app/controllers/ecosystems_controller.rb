class EcosystemsController < ApplicationController
  before_action :set_ecosystem, only: :show

  # GET /ecosystems or /ecosystems.json
  def index
    @ecosystems = Ecosystem.all
  end

  # GET /ecosystems/1 or /ecosystems/1.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ecosystem
    @ecosystem = Ecosystem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ecosystem_params
    params.require(:ecosystem).permit(:title)
  end
end
