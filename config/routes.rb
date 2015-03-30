FoosballRanks::Application.routes.draw do
  resources :rankings
  resources :games
  resources :predictions
  root to: "rankings#index"
end
