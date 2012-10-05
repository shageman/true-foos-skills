FoosballRanks::Application.routes.draw do
  resources :games
  resources :players

  root to: "games#index"
end
