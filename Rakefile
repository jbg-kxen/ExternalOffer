#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ExternalOffer::Application.load_tasks

require 'ci/reporter/rake/test_unit' if Rails.env.test?

namespace :db do
  namespace :test do
    task :load => :environment do
      Rake::Task["udf:load"].invoke
    end
  end
end