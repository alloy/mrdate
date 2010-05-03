TIME_SPECS = Dir.glob("spec/time/*_spec.rb")

def spec_command(specs)
  "macruby -r #{specs.join(" -r ")} -e \"\""
end

namespace :spec do
  # task :date do
  #   sh spec_command(DATE_SPECS)
  # end
  
  task :time do
    # sh spec_command(TIME_SPECS)
    sh spec_command(TIME_SPECS)
  end
end

task :kick do
  sh "kicker -e '#{spec_command(TIME_SPECS)}' ."
end