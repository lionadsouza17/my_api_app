class CommitsController < ApplicationController
  before_action :set_repository
  before_action :set_commit, only: [:show, :diff]

  # GET /repositories/:owner_name/commits/:commit_id
  def show
    # render json: @commit
    render json: { 
      "oid": @commit.id,
      "message": @commit.message  
    }
  end

  def show_diff
    @commit_hash = params[:commit_hash]
    @repository = Rugged::Repository.new('.')  # Assuming you are in the root directory of your Git repository
    @commit = @repository.lookup(@commit_hash)
    parent_commit = @commit.parents.first  # Get the first parent of the commit (assuming it's a simple linear history)

    if parent_commit
      diff = parent_commit.diff(@commit)
      @diff_text = diff.patch
    else
      @diff_text = "No parent commit found."
    end
  end
  
  private

  def set_repository
    @repository = Repository.find_by(owner_name: params[:owner_name], repository_name: params[:repository_name])
  end

  def set_commit
    @commit = @repository.commits.find_by(id: params[:commit_id])
  end
end
