require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect to "/recipes/#{Recipe.last.id}"
  end

  get '/recipes' do
    # binding.pry
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    # binding.pry
    @recipe = Recipe.find_by_id(params[:id])

    erb :edit
  end

  patch '/recipes/:id' do
    binding.pry
     @recipe = Recipe.find_by_id(params[:id])
     @recipe.name = params[:name]
     binding.pry
     @recipe.ingredients = params[:ingredients]
     @recipe.cook_time = params[:cook_time]
     binding.pry
     @recipe.save
     redirect to "/recipes/#{@recipe.id}"
     binding.pry
   end
  # post '/recipes' do
  #   @recipe = Recipe.create(params)
  #   redirect to "/recipes/#{@recipe.id}"
  # end

  delete '/recipes/:id/delete' do
    binding.pry
    @recipe = Recipe.find_by_id(params[:id])
    binding.pry
    @recipe.delete
    binding.pry
    redirect to "/index"

  end
end
