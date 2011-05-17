# Heroku Plugins: Now Gems

I hear you like gems...I'm going to gem your plugins. Allows heroku plugins to be installed as gems and loaded into the heroku client.

## Installation

To install this plugin, we just install it like any other heroku plugin

    heroku plugins:install git://github.com/hone/herogems.git

## Usage

To install a "herogem" (a gem that is a heroku plugin)

    gem install herobro
    heroku herogems:enable herobro

herogems:enable sets the herogem to be loaded

herogems:disable does not uninstall the gem from your system but just prevents it from being loaded

    heroku herogems:disable herobro

To completely remove a gem from your system, you'll need to uninstall the gem

    gem uninstall herobro

herogems by itself will list all the herogems installed.

    heroku herogems

    herobro

## License

Please see MIT-LICENSE for more details.

## Copyright

Copyright © 2011 Jonathan Dance, Terence Lee 
