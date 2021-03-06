gem 'rspec-rails', '>= 2.4.1', :group => [:development]

post_bundler_strategies << lambda do
  generate 'rspec:install'
  
  spec_helper_path = 'spec/spec_helper.rb'
    
  gsub_file spec_helper_path, 'config.fixture_path = "#{::Rails.root}/spec/fixtures"', ''
  gsub_file spec_helper_path, /(config.use_transactional_fixtures = true)/, '# \1'
  if @template_options[:db] == "mongodb"
    inject_into_file spec_helper_path, load_snippet('mongoid', 'rspec'), :after => "# config.use_transactional_fixtures = true\n"
  end

end
