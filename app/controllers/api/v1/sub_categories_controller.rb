# frozen_string_literal: true

class Api::V1::SubCategoriesController < ApplicationController
  before_action :load_category
  before_action :load_sub_category, only: %i[update show destroy]

  def index
    @sub_categories = @category.sub_categories
  end

  def show; end

  def create
    @sub_category = @category.sub_categories.new(sub_category_params)

    if @sub_category.save
      render :show
    else
      render_unprocessable_entity(@sub_category)
    end
  end

  def update
    if @sub_category.update(sub_category_params)
      render :show
    else
      render_unprocessable_entity(@sub_category)
    end
  end

  def destroy
    if @sub_category.destroy
      render :show
    else
      render_unprocessable_entity(@sub_category)
    end
  end

  private

  def load_category
    @category = Category.find(params[:category_id])
  end

  def load_sub_category
    @sub_category = @category.sub_categories.find(params[:id])
  end

  def sub_category_params
    params.require(:sub_category).permit(:name, :description)
  end
end
