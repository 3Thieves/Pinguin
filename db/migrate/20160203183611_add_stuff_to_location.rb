class AddStuffToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :verified, :boolean
    add_column :locations, :phone_number, :string
    add_column :locations, :link, :string
  end
end
