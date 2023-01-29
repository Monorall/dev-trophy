class Document < ApplicationRecord
  belongs_to :project
  has_many :issues, dependent: :destroy
end
