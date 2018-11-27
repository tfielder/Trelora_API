Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v0 do
      namespace :turing do
        post '/docs', to: 'turing#docs'
        post '/members', to: 'turing#members'
        post '/properties', to: 'turing#properties'
        post '/update_listing_consultation', to: 'turing#update_listing_consultation'
      end
    end
  end
end
