# Mingo

Mingo is a ruby ORM to provide a quick way to develop with a MongoDB database in Ruby applications.

Mingo is a database interface that abides to the [Mince](https://github.com/coffeencoke/mince/) interface API requirements and is officially supported by [Mince](https://github.com/coffeencoke/mince/).

# How to use it

View the [Mince Wiki](https://github.com/coffeencoke/mince/wiki) on details on how to use this gem.

Basically -

```
gem install mince mingo
```

```ruby
require 'mince'
require 'mingo'

interface = Mince::Mingo::Interface
interface.add 'tron_light_cycles', luminating_color: 'red', grid_locked: true, rezzed: false
interface.add 'tron_light_cycles', luminating_color: 'blue', grid_locked: true, rezzed: true
interface.find_all('tron_light_cycles') 
	# => [{:luminating_color=>"red", :grid_locked=>true, :rezzed=>false}, {:luminating_color=>"blue", :grid_locked=>true, :rezzed=>true}] 
interface.get_for_key_with_value('tron_light_cycles', :luminating_color, 'blue')
	# => {:luminating_color=>"blue", :grid_locked=>true, :rezzed=>true} 
```

Change the database name

```ruby
Mince::Mingo::Config.database = 'foo'
```

# Links

* [API Docs](http://rdoc.info/github/coffeencoke/mingo/update_to_v2/frames)
* [Travis CI](https://travis-ci.org/#!/coffeencoke/mingo)
* [Rubygems](https://rubygems.org/gems/mingo)
* [Github](https://github.com/coffeencoke/mingo)
* [Wiki](https://github.com/coffeencoke/mingo/wiki)
* [Mince](https://github.com/coffeencoke/mince)

# Contribute

This gem is officially supported by [Mince](https://github.com/coffeencoke/mince/), please go there to learn how to contribute.