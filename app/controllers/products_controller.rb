class ProductsController < ApplicationController
  def new
    @list= List.find(params[:list_id])
    @product = Product.new
  end

  def create
    @list = List.find(params[:list_id])
    @product = @list.products.build(params[:product])
    authorize! :manage, @product, message: "You need have created the list to do that"
    if @product.save
      flash[:notice] = "Producted Added!"
      redirect_to @list
    else
      flash[:error] = "Cannot add product at this time. :("
      render :back
    end 
  end

  def show
    @list = List.find(params[:list_id])
  end

  def index
    @products = Product.top_rated
  end

  def edit
  end
end
