# Dolarblue

[![Gem Version][GV img]][Gem Version]
[![Build Status][BS img]][Build Status]
[![Dependency Status][DS img]][Dependency Status]
[![Code Climate][CC img]][Code Climate]
[![Coverage Status][CS img]][Coverage Status]
[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/4a6a5549e2d3b59f3b59b12ab0ab70e9 "githalytics.com")](http://githalytics.com/elgalu/dolarblue)

## Description

Get instant notifications about changes on Argentine Peso vs US$ exchange values with particular interest in official vs. street "blue" reference prices.

[dolarblue][RubyGems] is a cross-platform System Tray tool that automatically queries AR$ vs US$ exchange values.

The term [blue][] denotes an important difference between the [real value][] of Argentine local currency (the argentine peso) versus the official value currently unreacheable to the general public.

Information source:
  http://ambito.com/economia/mercados/monedas/dolar/

## Installation

`$ gem install dolarblue`

## Usage (command-line)

To start the notification daemon simply run the execution script

    $ dolarblue

Mac OSX sample screenshot (Growl)
{TODO}

Ubuntu sample screenshot (libnotify)
{TODO}

Windows sample screenshot (GrowlForWindows)
{TODO}

## Contributing

1. Fork it.
2. Make your feature addition or bug fix and create your feature branch.
3. Update the [Change Log][].
3. Add specs/tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, create a new Pull Request.
5. Check that your pull request passes the [build][travis pull requests].

## License

Released under the MIT License. See the [LICENSE][] file for further details.

## Links

[RubyGems][] | [Documentation][] | [Source][] | [Bugtracker][] | [Build Status][] | [Dependency Status][] | [Code Climate][]


[bundle install]: http://gembundler.com/v1.3/man/bundle-install.1.html
[Gemfile]: http://gembundler.com/v1.3/gemfile.html
[LICENSE]: LICENSE.md
[Change Log]: CHANGELOG.md

[RubyGems]: https://rubygems.org/gems/dolarblue
[Documentation]: http://rubydoc.info/gems/dolarblue
[Source]: https://github.com/elgalu/dolarblue
[Bugtracker]: https://github.com/elgalu/dolarblue/issues

[travis pull requests]: https://travis-ci.org/elgalu/dolarblue/pull_requests

[Gem Version]: https://rubygems.org/gems/dolarblue
[Build Status]: https://travis-ci.org/elgalu/dolarblue
[Dependency Status]: https://gemnasium.com/elgalu/dolarblue
[Code Climate]: https://codeclimate.com/github/elgalu/dolarblue
[Coverage Status]: https://coveralls.io/r/elgalu/dolarblue

[GV img]: https://badge.fury.io/rb/dolarblue.png
[BS img]: https://travis-ci.org/elgalu/dolarblue.png
[DS img]: https://gemnasium.com/elgalu/dolarblue.png
[CC img]: https://codeclimate.com/github/elgalu/dolarblue.png
[CS img]: https://coveralls.io/repos/elgalu/dolarblue/badge.png?branch=master

[blue]:       http://es.wikipedia.org/wiki/D%C3%B3lar_blue
[real value]: http://www.buenosairesherald.com/tags/dollar
