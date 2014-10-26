Twitdog
=======

Twitdog is a dead simple Twitpic API client designed to allow you to painlessly download users' images.

Unlike other Twitpic API clients, Twitdog is designed to be tolerant of server unreliability. Twitpic's server is frequently overloaded as it shuts down; when it encounters errors, Twitdog will keep on trying until it works.

Requirements
------------

* Tested with Ruby 2.0 or later (may work with Ruby 1.9.3)

Installation
------------

* `rake build`
* `gem install pkg/twitdog-0.1.gem`

Twarchive
---------

Twitdog comes with a simple commandline tool called "twarchive", which downloads all of a user's photos along with all of the metadata and comments for each photo.

### Usage

To use twarchive, just run:

`twarchive USERNAME directory_to_put_photos_in`

You can also run `twarchive --help` to display a help message.

License
-------

Twitdog is licensed under the [WTFPL](http://www.wtfpl.net/).

Why dog though?
---------------

Twitdog was created to archive the corpus of [dogpictbot](https://twitter.com/dogpictbot). Also, dogs.
