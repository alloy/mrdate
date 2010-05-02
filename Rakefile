SPECS = %w{ new civil eql minus minus_month boat add add_month step downto upto hash relationship }
SPEC_COMMAND = "macruby -r #{SPECS.map { |s| "spec/#{s}_spec.rb" }.join(" -r ")} -e \"\""

task :spec do
  sh SPEC_COMMAND
end

task :kick do
  sh "kicker -e '#{SPEC_COMMAND}' ."
end