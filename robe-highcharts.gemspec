#!/usr/bin/env ruby
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "robe/highcharts/version"

Gem::Specification.new do |s|
  s.name = 'robe-highcharts'
  s.version = Robe::Highcharts::VERSION
  s.authors = ['Colin Gunn']
  s.email = ['colgunn@icloud.com']
  s.summary = 'Highcharts support for Robe'
  s.description = 'Provides a Robe::Client::Highchart component.'
  s.homepage = 'https://github.com/balmoral/robe-highcharts'
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.3.0'

  s.files = %w'README.md MIT-LICENSE' + Dir[File.join('lib', '**', '*')]
  s.require_paths = ['lib']
end
