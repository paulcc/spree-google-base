# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class GoogleBaseExtension < Spree::Extension
  version "1.0"
  description "Google Base Extension"
  url "http://spreehq.org"

  def activate
    Admin::ConfigurationsController.class_eval do
      before_filter :add_taxon_map_link, :only => :index
      def add_taxon_map_link
        @extension_links << {:link => admin_taxon_mapper_index_url, :link_text => 'Google Base', :description => 'Google Base'}
      end
    end

    AppConfiguration.class_eval do
      preference :google_base_title, :string, :default => 'Sand-Jar: Spree Demo'
      preference :public_domain, :string, :default => 'http://www.sand-jar.com/'
      preference :google_base_desc, :string, :default => 'Sand-Jar: Spree Demo'
      preference :google_base_ftp_username, :string, :default => ''
      preference :google_base_ftp_password, :string, :default => ''
    end

    Taxon.class_eval do
      has_one :taxon_map
    end
  end
end
