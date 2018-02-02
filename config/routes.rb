Rails.application.routes.draw do
  get '/healthcheck', to: 'healthcheck#alive'
end
