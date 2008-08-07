require 'rubygems'
require 'spec'
require 'spec/rake/spectask'
require 'pathname'

ROOT = Pathname(__FILE__).dirname.expand_path

AUTHOR = "Dirkjan Bussink"
EMAIL  = "d.bussink@gmail.com"
GEM_NAME = "dm-constraints"
GEM_VERSION = "0.0.1"
GEM_DEPENDENCIES = [["dm-core", ">=0.9.3"]]
GEM_CLEAN = ["log", "pkg"]
GEM_EXTRAS = { :has_rdoc => true, :extra_rdoc_files => %w[ README.txt LICENSE TODO ] }

PROJECT_NAME = "dm-constraints"
PROJECT_URL  = "http://github.com/dbussink/dm-constraints"
PROJECT_DESCRIPTION = PROJECT_SUMMARY = "Add foreign key constraints to DataMapper associations"

require ROOT + 'tasks/hoe'
require ROOT + 'tasks/gemspec'
require ROOT + 'tasks/install'
require ROOT + 'tasks/dm'
require ROOT + 'tasks/doc'
require ROOT + 'tasks/ci'
