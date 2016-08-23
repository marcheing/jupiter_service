Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'faculties' => 'faculties#read_faculties', as: :read_faculties
  get 'offer/:code' => 'offers#offer', as: :offer
end
