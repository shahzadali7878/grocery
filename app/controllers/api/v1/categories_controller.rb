# frozen_string_literal: true

class Api::V1::CategoriesController < ApplicationController
  before_action :load_category, only: %i[update show destroy]

  def index
    @categories = Category.all
  end

  def show; end

  def create
    @category = Category.new(category_params)

    if @category.save
      render :show
    else
      render_unprocessable_entity(@category)
    end
  end

  def update
    if @category.update(category_params)
      render :show
    else
      render_unprocessable_entity(@category)
    end
  end

  def destroy
    if @category.destroy
      render :show
    else
      render_unprocessable_entity(@category)
    end
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
