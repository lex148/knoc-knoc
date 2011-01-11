require File.expand_path("../lib/knoc-knoc/version", __FILE__)

Gem::Specification.new do |s|
  s.name     = %q{knoc-knoc}
  s.version  = KnocKnoc::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors  = ["lexchilds"]
  s.email    = %q{lex@childs.me}
  s.date     = %q{2011-01-10}
  s.homepage = %q{https://github.com/lex148/knoc-knoc}
  s.summary  = %q{A library to tell you who is there.}

  s.rdoc_options = ["--charset=UTF-8"]

  s.required_rubygems_version = ">= 1.3.6"
  #s.rubyforge_project = ''

  #s.add_dependency 'rest-client', ">= 0"
  #s.add_dependency 'activesupport', ">= 3.0"
  #s.add_dependency 'i18n'
  #s.add_dependency 'yajl-ruby', '>= 0.7.8'

  #s.add_development_dependency "bundler", ">= 1.0.0"
  #s.add_development_dependency "minitest"
  #s.add_development_dependency "vcr"
  #s.add_development_dependency "fakeweb"


  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'

  s.extra_rdoc_files = [
     "README.markdown"
  ]

  s.test_files = [
  ]
end


