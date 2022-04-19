# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :user

  root 'home#index'

  delete '/product_categories/:id', to: 'product_categories#destroy', as: 'destroy_product_category'
  delete '/promotions/:id', to: 'promotions#destroy', as: 'destroy_promotion'

  get '/promotions', to: 'promotions#index', as: 'all_promotions'
  get '/details' => 'promotions#details', :as => 'details_coupon'

  resources :product_categories

  resources :promotions do
    post 'generate_coupons', on: :member
  end

  resources :coupons, only: [] do
    post 'inactivate', on: :member
    post 'activate', on: :member
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  namespace 'api' do
    namespace 'v1' do
      resources :coupons, param: :code, only: %i[show] do
        post 'burn', on: :member
        get 'validates', on: :member
      end
    end
  end
end
