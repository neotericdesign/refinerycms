::Refinery::Application.routes.draw do

  match '/system/images/*dragonfly', :to => Dragonfly[:images]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :images, :except => :show do
      collection do
        get :insert
        get 'tagged/:tag_id' => 'images#tagged', :as => 'tagged'
      end
    end
  end
end
