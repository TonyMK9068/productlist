class ProductsController < ApplicationController
  def new
  end

  def create
    @list = List.find(params[:list_id])
    @product = @list.products.build(params[:product])
    
  end

  def show
  end

  def index
  end

  def edit
  end
end
