# Building Chef Cookbooks With DSC Resources

## Getting Started

### Generate a cookbook

* From your shell

```
chef generate cookbook dsc_workshop --email 'smurawski@chef.io' --copyright 'Chef Software' --license apache2
cd ./dsc_workshop
```

### Some background infrastructure

* open .kitchen.yml in your editor
* edit to look like https://gist.github.com/smurawski/ed173ee590f3c53581d948ab1c95a2c4#file-kitchen-yml

### Maybe a TDD approach

* from your shell

```
chef generate recipe ../dsc_workshop --copyright 'Chef Software' --license apache2
```

#### Write Our First Test

* open ./spec/unit/recipe/website_spec.rb in your editor
* edit to look like https://gist.github.com/smurawski/ed173ee590f3c53581d948ab1c95a2c4#file-website_spec-rb
* from your shell

```
chef exec rspec ./spec/unit
```

#### Write just enough recipe to make it pass

* edit to look like https://gist.github.com/smurawski/ed173ee590f3c53581d948ab1c95a2c4#file-website-rb
* open ./recipes/website.rb in your editor
* from your shell

```
chef exec rspec ./spec/unit
```

### Integration Test

* from your shell

```
mkdir integration/website/pester
```

* open ./test/integration/website.Tests.ps1 in your editor
* edit to look like https://gist.github.com/smurawski/ed173ee590f3c53581d948ab1c95a2c4#file-website-tests-ps1

* from your shell

```
kitchen verify website
```

### Working with External Modules

* open ./recipes/default.rb in your editor
* edit to look like https://gist.github.com/smurawski/33a623cef3b54caa6e5d440438ac7d2d#file-default-rb
* open ./recipes/website.rb in your editor
* edit to include https://gist.github.com/smurawski/33a623cef3b54caa6e5d440438ac7d2d#file-website-rb

### What about side by side modules?

* open ./metadata and add

```
depends 'dsc_contrib'
```

* open ./recipes/website.rb in your editor and update `dsc_resource 'website'` to include

```
  module_name ps_module_spec('xWebAdministration', '1.10.0.0')
```

### And those pesky CIM Instance Arrays?

* open ./recipes/website.rb in your editor
* add https://gist.github.com/smurawski/6c5d2e5fcd3fff8c59c770da0b164ec2#file-website-rb


### What about resources that want a PSCredential?

* use the `chef generate` command to generate a recipe called user
* add https://gist.github.com/smurawski/6c5d2e5fcd3fff8c59c770da0b164ec2#file-user-rb

### How might we ChefSpec with those helpers?

