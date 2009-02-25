require File.dirname(__FILE__) + '/../spec_helper'

describe TaxonMap do
  before(:each) do
    @taxon_map = TaxonMap.new
  end

  it "should be valid" do
    @taxon_map.should be_valid
  end
end
