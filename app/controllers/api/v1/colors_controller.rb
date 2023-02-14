# frozen_string_literal: true

class Api::V1::ColorsController < ApplicationController
  before_action :load_color, only: %i[update show destroy]

  def index
    @colors = Color.all
  end

  def show; end

  def create
    @color = Color.new(color_params)

    if @color.save
      render :show
    else
      render_unprocessable_entity(@color)
    end
  end

  def update
    if @color.update(color_params)
      render :show
    else
      render_unprocessable_entity(@color)
    end
  end

  def destroy
    if @color.destroy
      render :show
    else
      render_unprocessable_entity(@color)
    end
  end

  private

  def load_color
    @color = Color.find(params[:id])
  end

  def color_params
    params.require(:color).permit(:name, :code)
  end
end
