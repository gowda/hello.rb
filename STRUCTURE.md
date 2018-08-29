# Structure and interpretation of a ruby project
## Assumptions
`ruby` is installed using `rvm`. `bundler` is installed & available on the path.

## Setup
Create an empty directory to contain the project
```bash
$ mkdir hello.rb
```

`bundler` is used for dependency management. Initialize `bundler`
```bash
$ bundle init
```

`rake` is used to automate tasks. Add dependency in `Gemfile`:
```bash
echo "gem 'rake', '~> 10.0'" >> Gemfile
```

Create empty `Rakefile`
```bash
$ touch Rakefile
```

`rspec` is used for defining & running tests. Add dependency in `Gemfile`:
```bash
$ echo "gem 'rspec', '~> 3.0'" >> Gemfile
```

Create a new gemset before installing dependencies
```bash
$ rvm use 2.3.1@hellorb --create
```

For convenience, create `.ruby-version` & `.ruby-gemset` files to specify
versions.

```bash
$ echo "2.3.1" > .ruby-version
$ echo "hellorb" > .ruby-gemset
```

Install all dependencies. `--binstubs` also installs convenient local binaries
to help avoid using `bundle exec` prefix for every tool
```bash
$ bundle install --binstubs
```

Initialize `rspec`:
```bash
$ rspec --init
```

## Configuring `$LOAD_PATH`
All source files go inside `src` directory.

Following steps assume a program `hello` with the following source files:
```bash
|
|- src/hello.rb                      # depends on hello/defaults.rb
|- src/hello/defaults.rb
|- spec/fixtures/hello/samples.json  # test fixtures
|- spec/hello_spec.rb                # tests src/hello.rb
|- spec/hello/defaults_spec.rb       # tests src/hello/defaults.rb

```

## Run
### Run program
```bash
$ bin/rake hello run # 'run' is optional, 'bin/rake hello' defaults to same
```

To run the program directly, append `src/hello` to `ruby` load paths:
```bash
$ bundle exec ruby -I src/hello src/hello.rb
```

TODO: Automate running program from RubyMine

### Run console for a program
```bash
$ bin/rake hello console
```

To run the console directly, append `src/hello` to `$LOAD_PATH` & load
`hello` module:
```bash
$ bundle exec irb -I src -I src/hello -r hello
```

TODO: Automate running console for a program from RubyMine

### Run tests
```bash
$ bin/rake hello test
```

To run the tests with `rspec` directly:
```bash
$ FIXTURE_PATH="hello" bin/rspec \
      -I src -I src/hello \
      spec/hello_spec.rb spec/hello/defaults_spec.rb
```

TODO: Automate running tests from RubyMine
