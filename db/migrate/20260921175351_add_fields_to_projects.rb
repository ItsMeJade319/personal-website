class AddFieldsToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :title, :string
    add_column :projects, :description, :text
    add_column :projects, :slug, :string
    add_column :projects, :published, :boolean, default: false, null: false
    add_column :projects, :published_at, :datetime

    add_index :projects, :slug, unique: true
    add_index :projects, :published_at
  end
end
