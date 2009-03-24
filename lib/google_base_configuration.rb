class GoogleBaseConfiguration < Configuration
  preference :google_base_title, :string, :default => ''
  preference :public_domain, :string, :default => ''
  preference :google_base_desc, :string, :default => ''
  preference :google_base_ftp_username, :string, :default => ''
  preference :google_base_ftp_password, :string, :default => ''
end
