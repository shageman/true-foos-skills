FoosballRanks::Application.routes.draw do
  resources :news

  resources :games
  resources :players

  resource :stats, only: [:show]

  root to: "players#index"
end
