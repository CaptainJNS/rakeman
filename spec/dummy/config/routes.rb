Rails.application.routes.draw do
  mount Rakeman::Engine => "/rakeman"

  root to: 'pages#home'
end
