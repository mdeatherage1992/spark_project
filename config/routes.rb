Rails.application.routes.draw do
	post 'listings/download'
	root :to => "listings#index"
  resources :listings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
