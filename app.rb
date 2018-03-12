require_relative "config/application"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

get "/restaurants/" do

  @restaurants = Restaurant.all

  erb :index
end

get "/restaurants/new" do
  erb :new
end


post "/restaurants/create" do
  name = params[:name]
  address = params[:address]
  rating = params[:rating]

  restaurant = Restaurant.new
  restaurant.name = name
  restaurant.address = address
  restaurant.rating = rating

  restaurant.save

  redirect to("/restaurants/#{restaurant.id}")

end

get '/restaurants/:id/destroy' do
  id = params[:id]
  restaurant = Restaurant.find(id)
  restaurant.destroy
  redirect to('/restaurants/')
end

get '/restaurants/:id/edit' do
  id = params[:id]
  @restaurant = Restaurant.find(id)
  erb :edit
end

post '/restaurants/:id/update' do
  id = params[:id]
  restaurant = Restaurant.find(id)

  restaurant.name = params[:name]
  restaurant.address = params[:address]
  restaurant.rating = params[:rating]

  restaurant.save

  redirect to("/restaurants/#{restaurant.id}")
end

get "/restaurants/:id" do

  @restaurant = Restaurant.find(params[:id])

  erb :show
end

