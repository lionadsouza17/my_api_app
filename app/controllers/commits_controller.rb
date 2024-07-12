class CommitsController < ApplicationController
  # before_action :set_repository
  # before_action :set_commit, only: [:show]

  # GET /repositories/:owner_name/commits/:commit_id
  def show
    # render json: @commit
    # 
    @commit_hash = params[:commit_id]
    @repository = Rugged::Repository.new('.')
    @commit = @repository.lookup(@commit_hash)
    # parent_commit = @commit.parents.first

    if @commit
      render json: { 
      "oid": @commit.tree.oid,
      "message": @commit.message,
      "diff patch": @diff_text
    }
    else
      render json: { 
      "error": 'Failure'
    }
    end
  end

  def show_diff
    @commit_hash = params[:commit_id]
    @repository = Rugged::Repository.new('.')
    @commit = @repository.lookup(@commit_hash)
    parent_commit = @commit.parents.first

    if parent_commit
      diff = parent_commit.diff(@commit)
      @diff_text = diff.patch
      render json: { 
      "changeKind": "MODIFIED",
      "message": @commit.message,
      "diff patch": @diff_text
    }
    else
      @diff_text = "No parent commit found. intial commit!"
      render json: { 
      "changeKind": "intial commit",
      "message": @commit.message  
    }
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