# Ruby Weather

Very thin Ruby wrapper around the [Weather API](https://www.weatherapi.com/docs/) to demonstrate different approaches for testing code that uses [Faraday](https://lostisland.github.io/faraday/usage/).

The first uses regular RSpec stubbing when `Faraday.verb` is used. And the second uses Faraday provided stubs. In order to make use of this technique, a Faraday connection object should be used and should be injected into the class via constructor.

## Setup

Sign up for a free account at the [Weather API](https://www.weatherapi.com/) and get your API key.

```bash
cp .env.template .env
# enter your api key in .env
```

Use Ruby version as specified in [.ruby-version](./.ruby-version).

```
bundle install
```

Run interactively:

```
make console
> WeatherClient.new.today(city: 'Paris')
```

Run tests:

```
make test
```

Run rubocop:

```
make lint
```
