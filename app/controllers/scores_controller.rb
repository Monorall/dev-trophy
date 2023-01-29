class ScoresController < ApplicationController
  layout false

  def index
    @scores = Score.order('length(trophies) desc')
  end
end
