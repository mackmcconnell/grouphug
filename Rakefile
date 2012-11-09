#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require_relative 'lib/db_populator'

Grouphug::Application.load_tasks

desc "scrape"
task "db:scrape" do
  DbPopulator.scrape
end

desc "load into database"
task "db:populate" do
  DbPopulator.import
end
