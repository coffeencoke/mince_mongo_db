# MinceMongoDb

MinceMongoDb is a ruby ORM to provide a quick way to develop with a MongoDB database in Ruby applications.

It is a database interface that abides to the [Mince](https://github.com/coffeencoke/mince/) interface API requirements and is officially supported by [Mince](https://github.com/coffeencoke/mince/).

# How to use it

View the [Mince Wiki](https://github.com/coffeencoke/mince/wiki) on details on how to use this gem.

Basically -

```
gem install mince_mongo_db
```

```ruby
require 'mince_mongo_db'

interface = MinceMongoDb::Interface
interface.add 'tron_light_cycles', luminating_color: 'red', grid_locked: true, rezzed: false
interface.add 'tron_light_cycles', luminating_color: 'blue', grid_locked: true, rezzed: true
interface.find_all('tron_light_cycles') 
	# => [{:luminating_color=>"red", :grid_locked=>true, :rezzed=>false}, {:luminating_color=>"blue", :grid_locked=>true, :rezzed=>true}] 
interface.get_for_key_with_value('tron_light_cycles', :luminating_color, 'blue')
	# => <Mongo::Cursor:0x3fc8421cad14 namespace='mince.tron_light_cycles' @selector={} @cursor_id=>
```

Change the database name

```ruby
MinceMongoDb::Config.database_name = 'foo'
```

Change the database host

```ruby
MinceMongoDb::Config.database_host = 'db.myapp.com'
```

# Links

* [API Docs](http://rdoc.info/github/coffeencoke/mince_mongo_db/master/frames)
* [Travis CI](https://travis-ci.org/#!/coffeencoke/mince_mongo_db)
* [Rubygems](https://rubygems.org/gems/mince_mongo_db)
* [Github](https://github.com/coffeencoke/mince_mongo_db)
* [Wiki](https://github.com/coffeencoke/mince_mongo_db/wiki)
* [Issues](https://github.com/coffeencoke/mince_mongo_db/issues)
* [Mince](https://github.com/coffeencoke/mince)

# Contribute

This gem is officially supported by [Mince](https://github.com/coffeencoke/mince/), please go there to learn how to contribute.
