class AddCountToArtistsTags < ActiveRecord::Migration[5.1]
  def change
    add_column :artists_tags, :count, :int
  end
  def up
  	change_column :artists_tags, :count, :default => 1
  end
end
