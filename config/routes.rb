Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'all_faculties' => 'faculties#all_faculties', as: :all_faculties
  get 'faculty/:code' => 'faculties#single_faculty', as: :single_faculty
  get 'offer/:code' => 'offers#offer', as: :offer
end
