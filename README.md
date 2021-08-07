# Ruby Weather

Very thin Ruby wrapper around the [Weather API](https://www.weatherapi.com/docs/) to explore different approaches for testing code that uses [Faraday](https://lostisland.github.io/faraday/usage/).

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
