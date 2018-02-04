Rails.application.routes.draw do
  get '/healthcheck', to: 'healthcheck#alive'
  post '/battle', to: 'battle#create'
end
