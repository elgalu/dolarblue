## [In git](https://github.com/elgalu/dolarblue/compare/v0.4.0...HEAD)

### New Features
* n/a

### Bug Fixes
* n/a

### Chores
* Added more specs for increased coverage. (Leo Gallucci)
* Simplified and improved vcr cassettes usage. (Leo Gallucci)

## [v0.4.0](https://github.com/elgalu/dolarblue/tree/v0.4.0)

### New Features
* Changed information source from twitter to ambito.com. (Leo Gallucci)

### Bug Fixes
* Twitter anonymous access was discontinued so to avoid the user having to install their API token i moved to web-scraping. (Leo Gallucci)

### Chores
* Complete refactor of the app. (Leo Gallucci)
* Updated RSpec to use new syntax `expect` and remove `should` [expectation syntax](http://goo.gl/BGxqP). (Leo Gallucci)

## [v0.3.0](https://github.com/elgalu/dolarblue/tree/v0.3.0)

### New Features
* Split method buy_sell_factor into 2: buy_sell_official_factor & buy_sell_blue_factor. (Leo Gallucci)

### Bug Fixes
* n/a

### Chores
* Changed word "ilegal" value for more polite "street" value. (Leo Gallucci)

## [v0.2.0](https://github.com/elgalu/dolarblue/tree/v0.2.0)

### New Features
* Added "dolar tarjeta" values for 20% government fees on AR credit cards. (Leo Gallucci)

### Bug Fixes
* Fixed 1 digit rounding to fill with 0. (Leo Gallucci)

### Chores
* n/a

## [v0.1.0](https://github.com/elgalu/dolarblue/tree/v0.1.0)

### New Features
* Made backward compatible for ruby >= 1.9 (Leo Gallucci)

### Bug Fixes
* n/a

### Chores
* n/a

## [v0.0.1](https://github.com/elgalu/dolarblue/tree/v0.0.1)

## First gem release

### Features:
* Query Argentine Peso vs US$ exchange values with particular interest in official vs. ilegal (blue) reference prices. (Leo Gallucci)
