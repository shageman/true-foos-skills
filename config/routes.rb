FoosballRanks::Application.routes.draw do
  resources :games
  resources :players

  resource :stats, only: [:show]

  root to: "games#index"
end
