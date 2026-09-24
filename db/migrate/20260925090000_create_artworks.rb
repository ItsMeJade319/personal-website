class CreateArtworks < ActiveRecord::Migration[8.1]
  def change
    create_table :artworks do |t|
      t.string :title
      t.text :description
      t.string :medium
      t.integer :year
      t.string :slug
      t.boolean :published, default: false, null: false
      t.datetime :published_at

      t.timestamps
    end

    add_index :artworks, :slug, unique: true
    add_index :artworks, :published_at
  end
end
