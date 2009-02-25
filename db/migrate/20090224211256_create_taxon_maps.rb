class CreateTaxonMaps < ActiveRecord::Migration
  def self.up
    create_table :taxon_maps do |t|
      t.integer :taxon_id
      t.string :product_type
      t.integer :priority
      t.timestamps
    end
  end

  def self.down
    drop_table :taxon_maps
  end
end
