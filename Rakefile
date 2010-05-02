SPECS = %w{ new civil eql minus boat add add_month }
SPEC_COMMAND = "macruby -r #{SPECS.map { |s| "spec/#{s}_spec.rb" }.join(" -r ")} -e \"\""

task :spec do
  sh SPEC_COMMAND
end

task :kick do
  sh "kicker -e '#{SPEC_COMMAND}' ."
end