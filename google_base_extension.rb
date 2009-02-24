# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class GoogleBaseExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/google_base"

  # Please use google_base/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    # admin.tabs.add "Google Base", "/admin/google_base", :after => "Layouts", :visibility => [:all]
  end
end