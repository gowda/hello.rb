# hello.rb

Ruby application skeleton. Application can have multiple programs which can
be run independently. Details of the directory structure can be found in
[STRUCTURE.md](STRUCTURE.md)

## Program
### Files & directories
Assuming program with name `goodbye`.

#### Sources
Create `src/goodbye.rb` for the program.
```bash
$ touch src/goodbye.rb
```

If program needs to be structured into multiple classes & modules, place
everything other than main program in `src/goodbye` directory.
```bash
$ mkdir -p src/goodbye
```

#### Test specs
Create `spec/goodbye_spec.rb`.
```bash
$ touch spec/goodbye_spec.rb
```

Tests for any module or class defined in `src/goodbye` can be placed
separately in `spec/goodbye` directory.
```bash
$ mkdir -p spec/goodbye
```

Ensure that `spec_helper` is required before any code in test specs.
For `spec/goodbye_spec.rb`:
```bash
echo "require 'spec_helper' > spec/goodbye_spec.rb"
```

### Run
Run automation scripts depend on strict structure as explained in above
section.

Refer [run section in STRUCTURE.md](STRUCTURE.md#run)
