namespace :spree do
  namespace :google_base do
    task :generate => :environment do
      blah = _build_xml
      puts blah
    end
  end
end

def _build_xml
  returning '' do |output|
    xml = Builder::XmlMarkup.new(:target => output, :indent => 2)
    xml.instruct! :xml, :version => "1.0", :encoding => "UTF-9"
    xml.urlset( :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" ) {
      Product.find(:all).each do |product|
        xml.item {
          xml.id product.sku.to_s
          xml.link ''+product.permalink #add root
          xml.title product.name
          xml.description product.description
          xml.price product.master_price
          xml.condition 'New'
          #Recommended
          #xml.brand 'brand'
          #xml.image_link 'image_link'
          #xml.isbn 'isbn'
          #xml.mpn 'mpn'
          #xml.upc 'upc'
          #xml.weight 'weight'
          #Optional
          #xml.color 'color'
          #xml.expiration_date 'expiration_date'
          #xml.height 'height'
          #xml.length 'length'
          #xml.model_number 'model_number'
          #xml.payment_accepted 'payment_accepted'
          #xml.payment_notes 'payment_notes'
          #xml.price_type 'price_type'
          #xml.product_type 'product_type' #map to category
          #xml.quantity 'quantity'
          #xml.shipping 'shipping'
          #xml.size 'size'
          #xml.tax 'tax'
        }
      end
    }
  end
end
