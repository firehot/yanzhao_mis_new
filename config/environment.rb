# Be sure to restart your server when you modify this file
# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require 'thread'
# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
if Gem::VERSION >= "1.3.6"
  module Rails
    class GemDependency
      def requirement
        r = super
        (r == Gem::Requirement.default) ? nil : r
      end
    end
  end
end

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  #config.gem "mysql"
  #config.gem "rails",:version => "2.3.5"
  #config.gem "will_paginate",:lib =>"will_paginate"
  #config.gem "calendar_date_select"
  #config.gem "warden"
  #config.gem "devise",:version => '1.0.6'
  #config.gem "paperclip",:version => '2.3.0'
  #config.gem 'fastercsv'
  #config.gem 'searchlogic',:version => '2.4.2'
  #config.gem "aasm", :version =>'2.1.1', :lib => 'aasm'
  #config.gem 'rufus-scheduler', :source => "http://gemcutter.org"
  #config.gem 'default_value_for', :version => "~> 1.0.7"
  #
  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  config.active_record.observers = :receipt_observer,:shippment_observer,:vip_fee_info_observer,:org_observer,:message_observer,:position_observer
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Beijing'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :cn
end
