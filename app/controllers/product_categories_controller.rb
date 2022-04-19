# frozen_string_literal: true

class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product_category, only: %i[edit update destroy]

  def index
    @product_categories = ProductCategory.all
  end

  def new
    @product_category = ProductCategory.new
  end

  def edit; end

  def update; end

  def create
    @product_category = ProductCategory.new(category_params)
    if @product_category.save
      redirect_to product_categories_path
    else
      render :new
    end
  end

  def destroy
    @product_category.destroy
    redirect_to product_categories_path, notice: 'Categoria excluida com sucesso', status: :see_other
  end

  private

  def category_params
    params
      .require(:product_category)
      .permit(:name, :code)
  end

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end
end
