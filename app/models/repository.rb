class Repository < ApplicationRecord
  has_many :commits, dependent: :destroy
end
