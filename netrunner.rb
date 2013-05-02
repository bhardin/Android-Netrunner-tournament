require 'sinatra'

get '/' do
	erb :index
end

post '/add_player' do
	if params[:name]
		player = Player.new(params[:name])
		redirect "/players"
	end
end

get '/players' do
	@players = Players.all
	erb :players
end

get '/matches' do
	erb :matches
end

get '/rounds' do
	erb :rounds
end
