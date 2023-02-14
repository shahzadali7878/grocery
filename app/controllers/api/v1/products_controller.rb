# frozen_string_literal: true

class Api::V1::ProductsController < ApplicationController
  before_action :load_category
  before_action :load_sub_category
  before_action :load_product, only: %i[update show destroy]

  def index
    @products = @sub_category.products.includes(:colors, :sizes)
  end

  def show; end

  def create
    @product = @sub_category.products.new(product_params)

    if @product.save
      render :show
    else
      render_unprocessable_entity(@product)
    end
  end

  def update
    if @product.update(product_params)
      render :show
    else
      render_unprocessable_entity(@product)
    end
  end

  def destroy
    if @product.destroy
      render :show
    else
      render_unprocessable_entity(@product)
    end
  end

  private

  def load_category
    @category = Category.find(params[:category_id])
  end

  def load_sub_category
    @sub_category = @category.sub_categories.find(params[:sub_category_id])
  end

  def load_product
    @product = @sub_category.products.find(params[:id])
  end

  def product_params
    params.require(:product)
          .permit(
            :name, :description, :price, :discounted_price, :on_sale,
            color_ids: [], size_ids: []
          )
  end
end
