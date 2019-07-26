# Load the Rails application.
require_relative 'application'
Rails.application.routes.default_url_options[:host] = ENV["domain"]
# Initialize the Rails application.
Rails.application.initialize!
