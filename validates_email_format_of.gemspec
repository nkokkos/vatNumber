spec = Gem::Specification.new do |s|
  s.name = 'validates_greek_vat_number_format_of'
  s.version = '0.9 beta'
  s.summary = 'Validate a greek vat number'
  s.description = s.summary
  s.extra_rdoc_files = ['README.rdoc', 'CHANGELOG.rdoc', 'MIT-LICENSE']
  s.test_files = ['test/validates_email_format_of_test.rb','test/test_helper.rb','test/schema.rb','test/fixtures/person.rb', 'test/fixtures/people.yml']
  s.files = ['init.rb','rakefile.rb', 'lib/validates_greek_vat_number_format_of.rb','rails/init.rb']
  s.files << s.test_files
  s.files << s.extra_rdoc_files
  s.require_path = 'lib'
  s.has_rdoc = true
  s.rdoc_options << '--title' <<  'validates_greek_vat_number_format'
  s.author = "Nick Kokkos"
  s.email = "nkokkos@gmail.com"
  s.homepage = "http://"
end

