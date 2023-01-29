class Project < ApplicationRecord
  belongs_to :ecosystem
  has_many :documents, dependent: :destroy
  has_many :issues, through: :documents
end
