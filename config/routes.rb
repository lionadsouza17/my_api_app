Rails.application.routes.draw do
  get '/repositories/:owner_name/:repository_name/commits/:commit_id', to: 'commits#show', as: 'repository_commits'
end
