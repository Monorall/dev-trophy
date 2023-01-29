class Ecosystem < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :documents, through: :projects
  has_many :issues, through: :projects
end
