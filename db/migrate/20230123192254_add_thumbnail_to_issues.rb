class AddThumbnailToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :thumbnail, :string
  end
end
