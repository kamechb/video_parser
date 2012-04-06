require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'spec'
require 'spec/rake/spectask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the video_parser gem.'
Spec::Rake::SpecTask.new(:test) do |t|
	t.spec_files = FileList['spec/**/*_spec.rb']
	t.spec_opts = ['-c','-f','nested']
end

desc 'Generate documentation for the video_parser gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'VideoParser'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


PKG_VERSION = "0.1.0"
PKG_FILES = FileList[
    "lib/**/*", "spec/**/*", "Rakefile", "README"
]

# Genereate the package
spec = Gem::Specification.new do |s|

  #### Basic information.

  s.name = 'video_parser'
  s.version = PKG_VERSION
  s.summary = <<-EOF
    This gem is used to get video info from youku, tudou, slideshare.
  EOF
  s.description = <<-EOF
    This gem is used to get video info from youku, tudou, slideshare.
  EOF

  #### Which files are to be included in this gem?  Everything!  (Except CVS directories.)

  s.files = PKG_FILES

  #### Load-time details: library and application (you will need one or both).

  s.require_path = 'lib'

  s.add_dependency('httparty')
  s.add_dependency('nokogiri')

  #### Documentation and testing.

  s.has_rdoc = true

  #### Author and project details.

  s.authors = ["kame"]
  s.email = ["kamechb@gmail.com"]
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
