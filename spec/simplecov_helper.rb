require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

SimpleCov.start do
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group 'Helpers', 'app/helpers'
  add_group 'Views', 'app/views'
  add_group 'Lib', 'lib'
end

all_files = Dir['app/**/*.rb','app/**/*.haml','app/**/*.erb', 'lib/**/*.rb']
base_result = {}
all_files.each do |file|
  absolute = File::expand_path(file)
  lines = File.readlines(absolute, :encoding => 'UTF-8')
  base_result[absolute] = lines.map do |l|
    l.strip!
    l.empty? || l =~ /^end$/ || l[0] == '#' ? nil : 0
  end
end

SimpleCov.at_exit do
  coverage_result = Coverage.result
  covered_files = coverage_result.keys
  covered_files.each do |covered_file|
    base_result.delete(covered_file)
  end
  merged = SimpleCov::Result.new(coverage_result).original_result.merge_resultset(base_result)
  result = SimpleCov::Result.new(merged)
  result.format!
end
