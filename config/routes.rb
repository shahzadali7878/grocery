# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :colors, except: %i[new edit]
      resources :sizes,  except: %i[new edit]

      resources :categories, except: %i[new edit] do
        resources :sub_categories, except: %i[new edit] do
          resources :products, except: %i[new edit]
        end
      end
    end
  end
end
