class Addloctoprayer < ActiveRecord::Migration
  def self.up
     add_column :prayers, :lat, :string
     add_column :prayers, :lang, :string
     
  end

  def self.down
  end
end
