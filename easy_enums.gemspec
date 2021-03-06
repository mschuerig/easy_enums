# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{easy_enums}
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Schuerig"]
  s.date = %q{2009-05-30}
  s.description = %q{Simplistic enumerations for ActiveRecord.

Consider using enumerate_by, a more mature solution to the
same problem

http://github.com/pluginaweek/enumerate_by}
  s.email = ["michael@schuerig.de"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/easy_enums.rb", "rails/init.rb", "test/test_easy_enums.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/mschuerig/easy_enums}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{easy_enums}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Simplistic enumerations for ActiveRecord}
  s.test_files = ["test/test_helper.rb", "test/test_easy_enums.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.0.2"])
      s.add_development_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.0.2"])
      s.add_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.0.2"])
    s.add_dependency(%q<newgem>, [">= 1.4.1"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
