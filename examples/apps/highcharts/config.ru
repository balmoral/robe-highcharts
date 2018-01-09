require 'bundler/setup'
Bundler.require

require './lib/highcharts-example/server/app'
run ::App.instance
