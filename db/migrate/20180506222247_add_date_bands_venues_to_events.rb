class AddDateBandsVenuesToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :event_date, :datetime
    add_column :events, :bands, :string
    add_column :events, :venue, :string
  end
end
