class CreateFeatures < ActiveRecord::Migration[8.1]
  def change
    create_table :features do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :position, default: 0, null: false

      t.timestamps
    end

    add_index :features, [ :project_id, :position ]
  end
end
