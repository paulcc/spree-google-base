class GoogleBaseConfiguration < Configuration
  preference :google_base_title, :string, :default => 'My Site'
  preference :public_domain, :string, :default => 'http://www.mysite.com/'
  preference :google_base_desc, :string, :default => 'My Description'
  preference :google_base_ftp_username, :string, :default => ''
  preference :google_base_ftp_password, :string, :default => ''
end
