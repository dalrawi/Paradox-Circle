class AddCountToArtistsTags < ActiveRecord::Migration[5.1]
  def change
    add_column :artists_tags, :count, :int
  end
end
