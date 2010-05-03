DATE_SPECS = %w{
  new civil eql minus minus_month boat add add_month step downto upto hash
  relationship strftime
}.map { |f| "date/#{f}" }

TIME_SPECS = %w{
  initialize now at usec comparison plus minus day mday wday hour min sec
  monday tuesday wednesday thursday friday saturday sunday
}.map { |f| "time/#{f}" }

def spec_command(specs)
  "macruby -r #{specs.map { |s| "spec/#{s}_spec.rb" }.join(" -r ")} -e \"\""
end

namespace :spec do
  task :date do
    sh spec_command(DATE_SPECS)
  end
  
  task :time do
    sh spec_command(TIME_SPECS)
  end
end

task :kick do
  sh "kicker -e '#{spec_command(TIME_SPECS)}' ."
end