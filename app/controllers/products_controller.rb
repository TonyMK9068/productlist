class ProductsController < ApplicationController

  def create
    @list = List.find(params[:list_id])
    @product = @list.products.build(params[:product])
    authorize! :create, @product, message: "You need have created the list to do that"
    if @product.save
      flash[:notice] = "Producted Added!"
      redirect_to @list
    else
      flash[:error] = "Cannot add product at this time. :("
      render :back
    end 
  end

  def index
    @products = Product.top_ten
    authorize! :read, Product
  end

  def destroy
    @list = List.find(params[:list_id])
    @product = Product.find(params[:id])
    authorize! :update, @product, message: "Not authorized to do that."
    if @product.destroy
      flash[:notice] = "Item removed successfully"
      redirect_to :back
    else
      flash[:error] = "An error occured while deleting item from list."
      redirect_to :back
    end
  end 
end
