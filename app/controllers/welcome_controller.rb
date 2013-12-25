class WelcomeController < ApplicationController
  def index
    @index_results = Product.all.sample(6)
    
  end
end
