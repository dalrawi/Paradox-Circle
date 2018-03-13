class JoinTableArtistsTags < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :artists, :tags do |t|
  		t.index [:artist_id, :tag_id]
  	end
  end
end
