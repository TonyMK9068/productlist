class WelcomeController < ApplicationController
  def index
    @index_results = Product.all.sample(10)
    
  end
end
