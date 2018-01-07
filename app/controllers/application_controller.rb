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

     @recipe = Recipe.find_by_id(params[:id])
     @recipe.name = params[:name]
     @recipe.ingredients = params[:ingredients]
     @recipe.cook_time = params[:cook_time]
     @recipe.save
      erb :show
       #redirect to "/recipes/#{@recipe.id}"
   end

  post '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete

    redirect to "/recipes"

  end
end
