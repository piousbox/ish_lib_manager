source 'https://rubygems.org'

# Declare your gem's dependencies in ish_lib_manager.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

gem 'haml'

group :test, :development, :development_production, :util do
  gem 'ish_lib_engine',  :path => '/home/piousbox/projects/microsites/ish_lib_engine'
  gem 'ish_lib_assets',  :path => '/home/piousbox/projects/microsites/ish_lib_assets'
  # gem 'ish_lib_travel',  :path => '/home/piousbox/projects/microsites/ish_lib_travel'
  
  gem 'rspec'
  
end
