task FileList["src/*.rb"].pathmap("%n") do
  subcommand_list = ['run', 'test', 'console', 'help']
  name = ARGV.shift
  subcommand = ARGV.shift
  unless subcommand_list.include?(subcommand)
    ARGV.unshift(subcommand)
    subcommand = 'run'
  end

  load_paths = "-I src -I src/#{name}"
  load_modules = "-r #{name}"

  source = "src/#{name}.rb"
  specs = FileList.new("spec/#{name}_spec.rb", "spec/#{name}/*.rb")

  args = ARGV.join(' ')

  subcommands = {
    'run' => -> do
      sh "bundle exec ruby #{load_paths} #{source} #{args}"
    end,
    'test' => -> do
      sh "FIXTURE_PATH='#{name}' bin/rspec #{load_paths} #{specs}"
    end,
    'console' => -> do
      sh "bundle exec irb #{load_paths} #{load_modules}"
    end,
    'help' => -> do
      puts "Usage: bin/rake #{name} [subcommand|help]"
      puts ""
      puts "Subcommands:"
      puts "run      - Run #{source}. Default subcommand"
      puts "console  - Start an irb console with #{source} loaded"
      puts "test     - Runs rspec tests in #{specs}"
      puts "help     - Show this message"
    end
  }
  subcommands[subcommand].call
  exit
end
