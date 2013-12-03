class ProductsController < ApplicationController
  def new
    @list= List.find(params[:list_id])
    @product = Product.new
  end

  def create
    @list = List.find(params[:list_id])
    @product = @list.products.build(link: params[:link], product_number: params[:product_number], name: params[:name], price: params[:price])
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
  end

  def edit
  end
end
