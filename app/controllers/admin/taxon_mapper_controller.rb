class Admin::TaxonMapperController < Admin::BaseController
  resource_controller

  def index
    @taxons = Taxon.find(:all)
    @taxons.each do |taxon|
      if !taxon.taxon_map
        taxon_map = TaxonMap.new(:product_type => '', :taxon_id => taxon.id, :priority => 0)
        taxon_map.save
        taxon.taxon_map = taxon_map
      end
    end
  end

  def update
    TaxonMap.delete(TaxonMap.find(:all))
    params[:tax_id].each do |k, v|
      taxon_map = TaxonMap.new(:product_type => v, :taxon_id => k, :priority => params[:priority][k].to_i || 0)
      taxon_map.save
    end
    redirect_to admin_taxon_mapper_index_url
  end
end
