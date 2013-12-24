class WelcomeController < ApplicationController
  def index
    @index_results = Product.all.sample(7)
    
  end
end
