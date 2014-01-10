class ProductsController < ApplicationController
  respond_to :html, :js
  
  def create
    @list = List.find(params[:list_id])
    @product = @list.products.build(params[:product])
    authorize! :create, @product, message: "You need have created the list to do that"
    if @product.save
      flash[:notice] = "Producted Added!"
    else
      flash[:error] = "Cannot add product at this time. :("
    end
    
    respond_with(@product) do |f|
      f.html { redirect_to list_path(@list) }
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
    else
      flash[:error] = "An error occured while deleting item from list."
    end
    respond_with(@product) do |f|
      f.html { redirect_to list_path(@list) }
    end
  end 
end
