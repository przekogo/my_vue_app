Rails.application.routes.draw do
  # API routes
  namespace :api do
    resources :search, only: [:index]
    resources :cities, only: [:index]
  end

  # Redirect all requests to the frontend
  root to: redirect('/index.html')
  get '*path', to: 'application#frontend', constraints: ->(req) { req.format.html? }
end
