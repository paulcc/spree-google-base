require 'net/ftp'

namespace :db do
  desc "Bootstrap your database for Spree."
  task :bootstrap  => :environment do
    # load initial database fixtures (in db/sample/*.yml) into the current environment's database
    ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
    Dir.glob(File.join(GoogleBaseExtension.root, "db", 'sample', '*.{yml,csv}')).each do |fixture_file|
      Fixtures.create_fixtures("#{GoogleBaseExtension.root}/db/sample", File.basename(fixture_file, '.*'))
    end
  end
end

namespace :google_base do
  desc "Copies public assets of the Google Base to the instance public/ directory."
  task :update => :environment do
    is_svn_git_or_dir = proc {|path| path =~ /\.svn/ || path =~ /\.git/ || File.directory?(path) }
    Dir[GoogleBaseExtension.root + "/public/**/*"].reject(&is_svn_git_or_dir).each do |file|
      path = file.sub(GoogleBaseExtension.root, '')
      directory = File.dirname(path)
      puts "Copying #{path}..."
      mkdir_p RAILS_ROOT + directory
      cp file, RAILS_ROOT + path
    end
  end
  task :generate => :environment do
    results = '<?xml version="1.0"?>' + "\n" + '<rss version="2.0" xmlns:g="http://base.google.com/ns/1.0">' + "\n" + _filter_xml(_build_xml) + '</rss>'
    File.open("#{RAILS_ROOT}/public/google_base.xml", "w") do |io|
      io.puts(results)
    end
  end
  task :transfer => :environment do
    ftp = Net::FTP.new('uploads.google.com')
    ftp.login(Spree::GoogleBase::Config[:google_base_ftp_username], Spree::GoogleBase::Config[:google_base_ftp_password])
    ftp.put("#{RAILS_ROOT}/public/google_base.xml", 'google_base.xml')
    ftp.quit() 
  end
end

def _get_product_type(product)
  product_type = ''
  priority = -1000
  product.taxons.each do |taxon|
    if taxon.taxon_map && taxon.taxon_map.priority > priority
      priority = taxon.taxon_map.priority
      product_type = taxon.taxon_map.product_type
    end
  end
  product_type
end

def _filter_xml(output)
  fields = ['price', 'brand', 'condition', 'image_link', 'product_type', 'id', 'quantity', 'mpn']
  1.upto(fields.length - 1) { |i| output = output.gsub(fields[i] + '>', 'g:' + fields[i] + '>') }
  output
end
  
def _build_xml
  returning '' do |output|
    @public_dir = Spree::GoogleBase::Config[:public_domain] || ''
    xml = Builder::XmlMarkup.new(:target => output, :indent => 2, :margin => 1)
    xml.channel {
      xml.title Spree::GoogleBase::Config[:google_base_title] || ''
      xml.link @public_dir
      xml.description Spree::GoogleBase::Config[:google_base_desc] || ''
      Product.find(:all, :include => [ :images, :taxons ]).each do |product|
        xml.item {
          xml.id product.id.to_s
          xml.mpn product.sku.to_s	#remove if the sku is not the same as the manufacturer's part number
          xml.title product.name
          xml.link @public_dir + 'products/' + product.permalink
          xml.description CGI.escapeHTML(product.description)
          xml.price product.master_price
          xml.condition 'new'
          xml.image_link @public_dir.sub(/\/$/, '') + product.images.first.attachment.url(:product) unless product.images.empty?
          xml.product_type _get_product_type(product)
          #TODO: xml.quantity, xml.brand
          
          #See http://base.google.com/support/bin/answer.py?answer=73932&hl=en for all other fields
        }
      end
    }
  end
end
