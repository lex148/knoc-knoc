# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
#require "knoc-knoc/version"
require File.expand_path("../lib/knoc-knoc/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "knoc-knoc"
  s.version     = KnocKnoc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lex Childs"]
  s.email       = ["lex@childs.me"]
  s.homepage    = %q{https://github.com/lex148/knoc-knoc}
  s.summary     = %q{A library to tell you who is there.}


  s.rubyforge_project = "knoc-knoc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'net-ping', ">= 1.3.7"

end
