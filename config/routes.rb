Rails.application.routes.draw do
  root 'content#lookup'

  scope 'content' do
    match '', to: 'content#lookup', as: :content_index, via: [:get, :post]
    post '/summary', to: 'content#summary', as: :content_summary
  end
end
