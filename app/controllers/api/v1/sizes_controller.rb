# frozen_string_literal: true

class Api::V1::SizesController < ApplicationController
  before_action :load_size, only: %i[update show destroy]

  def index
    @sizes = Size.all
  end

  def show; end

  def create
    @size = Size.new(size_params)

    if @size.save
      render :show
    else
      render_unprocessable_entity(@size)
    end
  end

  def update
    if @size.update(size_params)
      render :show
    else
      render_unprocessable_entity(@size)
    end
  end

  def destroy
    if @size.destroy
      render :show
    else
      render_unprocessable_entity(@size)
    end
  end

  private

  def load_size
    @size = Size.find(params[:id])
  end

  def size_params
    params.require(:size).permit(:name, :code)
  end
end
