class Addlocationprayer < ActiveRecord::Migration
  def self.up
     add_column :prayers, :location, :string
     add_column :prayers, :title, :string
     add_column :prayers, :description, :string
  end

  def self.down
  end
end
