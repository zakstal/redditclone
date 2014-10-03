RedditClone::Application.routes.draw do

  resources :users, only: [:new, :create, :show] do
    resources :subs, only: [:new, :create]
  end

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:new] do
    resources :posts, only: [:new, :create]
  end

  resources :posts, except: [:new, :create] do
    resources :comments, only: [:new,:create]
  end

end
