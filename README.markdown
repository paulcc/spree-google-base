SUMMARY
=======

This extension allows you to use Google Base to list products for free that will appear in Google Product Search (http://www.froogle.com/).

<a href="http://base.google.com/support/bin/answer.py?answer=25277&topic=2904">Learn more about Google Base</a>

INSTALLATION
------------

1. Clone the git repo to SPREE_ROOT/vendor/extensions/google_base

      git clone git://github.com/stephp/spree-google-base.git google_base

2. Run rake db:migrate from SPREE_ROOT

3. Edit product_type, priorities in spree admin.

4. Edit SPREE_ROOT/vendor/extensions/google_base/google_base_extension.rb to set preferences for the feed title, public domain, feed description.

5. Create google base account. Create google base ftp account. Create data feed in google base with a type "Products" and name "google_base.xml".

6. Edit SPREE_ROOT/vendor/extensions/google_base/google_base_extension.rb to set preferences for google base ftp username and password.

7. Run rake spree:extensions:google_base:generate to generate feed. Verify feed exists (SPREE_ROOT/public/google_base.xml).

8. FTP file with 'rake spree:extensions:google_base:transfer'. Verify in Google Base that feed has been uploaded.


CRONJOBS
--------

There are two options to regulate google base product update:

A) Setup cronjobs to run 'rake spree:extensions:google_base:generate' and 'rake spree:extensions:google_base:transfer'

B) Setup cronjob to run 'rake spree:extensions:google_base:generate' and schedule the file to be uploaded via Google Base admin from public_domain/google_base.xml
