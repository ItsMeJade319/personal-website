class AddDemoUrlToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :demo_url, :string
  end
end
