# frozen_string_literal: true

Rails.application.routes.draw do
  resources :update_coins, only: %i[index]
  resources :best_coin, only: %i[index]
end
