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
    @products = Product.top_ten
  end

  def destroy
    @list = List.find(params[:list_id])
    @product = Product.find(params[:id])
    authorize! :manage, @product, message: "Not authorized to do that."
    if @product.destroy
      flash[:notice] = "Item removed successfully"
      redirect_to :back
    else
      flash[:error] = "An error occured while deleting item from list."
      redirect_to :back
    end
  end 
end
