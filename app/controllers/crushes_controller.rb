class CrushesController < ApplicationController
  def new
  end

  def create
    render text: params[:crush].inspect
  end
end
