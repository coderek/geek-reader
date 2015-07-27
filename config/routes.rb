Reader::Application.routes.draw do
  resources :authentications

  resources :users

  get "login"                           => "sessions#new", as: "login"
  post "login"                          => "sessions#create"
  delete "sessions"                     => "sessions#destroy", as: "logout"
  get "register"                        => "users#new", as: "register"
  get "entries/unread"                  => "entries#unread"
  get "refresh_unread"                  => "entries#refresh_unread"
  get "entries/starred"                 => "entries#starred"
  get "reader"                          => "main#reader", as: "reader"
  get "categories/:category_id/entries" => "entries#category"
  post "import_feeds"                   => "feeds#import_feeds"

  get "auth/:provider/callback"         => "authentications#create"

  resources :settings do
    collection do
      get "preference"
      get "categories"
    end
  end

  resources :categories do
    member do
      get "feeds"
    end
  end
  resources :feeds do
    member do
      post "mark_read"
    end
    resources :entries do
      collection do
        get "refresh"
      end
    end
  end
  root "main#index"
end
