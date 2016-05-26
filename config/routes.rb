Rails.application.routes.draw do
  root 'content#lookup'

  scope 'content' do
    get  '',          to: 'content#lookup'
    post '/summary',  to: 'content#summary', as: :content_summary
  end
end
