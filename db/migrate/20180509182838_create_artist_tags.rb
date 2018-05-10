class CreateArtistTags < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_tags do |t|
      t.references :artist, foreign_key: true
      t.references :tag, foreign_key: true
      t.integer :tag_count

      t.timestamps
    end
  end
end
