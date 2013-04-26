require 'rubygems'
require 'bundler'
Bundler.require :development

Releasy::Project.new do
  name 'Seven Stars'
  version '.01'
  verbose

  executable Rake::FileList.new("game.rb")
  files Rake::FileList.new("*.rb", "./images/**/*", "*.wav")
  add_link "https://github.com/andrewfader/sevenstars", "GitHub"

  add_build :osx_app do
    url "com.github.sevenstars"
    wrapper "wrappers/gosu-mac-wrapper-0.7.44.tar.gz"
    add_package :tar_gz
  end
end
