require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

desc "Test UPS Integration"
task :test => ['test:ups_shipping']

namespace :test do
  Rake::TestTask.new(:units) do |t|
    t.libs << "test"
    t.pattern = 'test/unit/**/*_test.rb'
    t.verbose = true
  end

  Rake::TestTask.new(:remote) do |t|
    t.libs << "test"
    t.pattern = 'test/remote/*_test.rb'
    t.verbose = true
  end

    Rake::TestTask.new(:ups_shipping) do |t|
        t.libs << "test"
        t.pattern = 'test/remote/ups_shipping_test.rb'
        t.verbose = true
    end

    Rake::TestTask.new(:fedex_shipping) do |t|
        t.libs << "test"
        t.pattern = 'test/remote/fedex_shipping_test.rb'
        t.verbose = true
    end
end

desc "Default Task"
task :default => 'test:units'

desc "Run the unit and remote tests"
task :test => ['test:units','test:remote']
