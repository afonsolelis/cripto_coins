# frozen_string_literal: true

Rails.application.routes.draw do
  resources :best_coin, only: %i[index]
  resources :coins, only: %i[index]
end
