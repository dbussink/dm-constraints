# Needed to import datamapper and other gems
require 'rubygems'
require 'pathname'

# Add all external dependencies for the plugin here
gem 'dm-core', '>=0.9.4'
require 'dm-core'

# Require plugin-files
require Pathname(__FILE__).dirname.expand_path / 'dm-constraints' / 'data_objects_adapter'
require Pathname(__FILE__).dirname.expand_path / 'dm-constraints' / 'sqlite3_adapter'

module DataMapper
  module Adapters
    class DataObjectsAdapter
      include Extlib::Hook
      include DataMapper::Constraints::DataObjectsAdapter::SQL
      include DataMapper::Constraints::DataObjectsAdapter::Migration
    end
  end
end
