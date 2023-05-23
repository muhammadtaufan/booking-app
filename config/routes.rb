Rails.application.routes.draw do
  namespace :v1 do
    post '/reservations', to: 'reservations#create_reservation'
  end
end
