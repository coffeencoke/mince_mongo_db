# MinceMongoDb

[![Travis CI](https://travis-ci.org/coffeencoke/mince_mongo_db.png)](https://travis-ci.org/#!/coffeencoke/mince_mongo_db)

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
all = interface.find_all('tron_light_cycles') 
  # => <Mongo::Cursor:0x3fccb15d16b0 namespace='mince.tron_light_cycles' @selector={} @cursor_id=>
all.to_a
  # => [{"_id"=>BSON::ObjectId('511af435d20cae9055000001'), "luminating_color"=>"red", "grid_locked"=>true, "rezzed"=>false}, {"_id"=>BSON::ObjectId('511af435d20cae9055000002'), "luminating_color"=>"blue", "grid_locked"=>true, "rezzed"=>true}]
interface.get_for_key_with_value('tron_light_cycles', :luminating_color, 'blue')
  # => {"_id"=>BSON::ObjectId('511af435d20cae9055000002'), "luminating_color"=>"blue", "grid_locked"=>true, "rezzed"=>true}
```

Change some configs

```ruby
MinceMongoDb::Config.database_name = 'foo'          # Defaults to 'mince'
MinceMongoDb::Config.database_host = 'db.myapp.com' # Defaults to 'localhsot'
MinceMongoDb::Config.username = 'app_db_user'       # Defaults to none
MinceMongoDb::Config.password = 'passw0rd'          # Defaults to none

# Or

MinceMongoDb::Config.options = {
  database_name: 'foo',
  database_host: 'db.myapp.com',
  username: 'app_db_user',
  password: 'passw0rd'
}
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
