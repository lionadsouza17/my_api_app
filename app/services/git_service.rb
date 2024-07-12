require 'rugged'

class GitService < ApplicationService
  def initialize(repository_path:, commit_sha:)
    @repository_path = repository_path
    @repo = Rugged::Repository.new(repository_path)
  end

  def call
    binding.pry
    commit = repo.lookup(commit_sha)
    binding.pry
    parent = commit.parents.first  # Get the first parent (typically the direct parent)

    return nil if parent.nil?  # If there's no parent, return nil or handle accordingly

    diff = parent.diff(commit)
    diff.patch  # Get the diff as a patch string
  end

  private

  attr_reader :repository_path, :repo, :commit_sha
end