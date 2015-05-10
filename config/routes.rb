Grayherd::Application.routes.draw do
  require 'sub_domain.rb'
  #get "organizations/index"
  break if ARGV.join.include? 'assets:precompile'
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  constraints SubDomain do
    root :to => "organizations#show"
  end

  resources :seasons

  match "/sync/servertime" => "registrations#servertime", :via => [:get]

  resources :registrations

  resources :groups

  resources :people

  resources :organizations

  resources :export

  # root :to => 'organizations#index'

end
