lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "Workbox automaton"
  spec.version       = '1.0'
  spec.authors       = ["Dario Daic"]
  spec.email         = ["dariodaic5.1@gmail.com"]
  spec.summary       = %q{Script for creating a folder structure on Dropbox.}
  spec.license       = "Infinum"

  spec.files         = ['lib/automaton.rb']
  spec.executables   = ['bin/automaton']
  spec.test_files    = ['tests/test_automaton.rb']
  spec.require_paths = ["lib"]
end
