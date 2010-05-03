DATE_SPECS = %w{ new civil eql minus minus_month boat add add_month step downto upto hash relationship strftime }.map { |f| "date/#{f}" }

def spec_command(specs)
  "macruby -r #{specs.map { |s| "spec/#{s}_spec.rb" }.join(" -r ")} -e \"\""
end

namespace :spec do
  task :date do
    sh spec_command(DATE_SPECS)
  end
end

# task :kick do
#   sh "kicker -e '#{SPEC_COMMAND}' ."
# end