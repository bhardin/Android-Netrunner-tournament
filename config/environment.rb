require 'sinatra'

get '/' do
	$tournament = Tournament.new
	"<h1>Tournament Runner</h1>"
end

post '/add_player' do
	if params[:name]
		player = Player.new(params[:name])
		$tournament.add_player(player)
		redirect "/players"
	end
end

get '/players' do
	$tournament.players
end

get '/matches' do

end

get '/rounds' do

end
