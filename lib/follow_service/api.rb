require 'sinatra'

configure do
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/follow_service.db"
  )
end

post '/users/:id/follows' do
  follow = Follow.create!(
    follower_id: params[:follower_id],
    followed_id: params[:id]
  )
  
  [201, {'Content-Type' => 'application/json'}, follow.to_json]
end
