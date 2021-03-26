# Lexorank Demo Application

This little Rails App demonstrates the power of the [Lexorank Gem](https://www.github.com/richardboehme/lexorank) and shows how to use it.

You can visit the live demo [here](https://lexorank.richardboeh.me).

## Development

### Setup Application

Install dependencies:

* Ruby Version: 3.0.0
* Yarn
* `libmysql-dev`

This project uses MySQL / MariaDB. If you want to you can use the `docker-compose.yml` file to set up a database for you. Just run `docker-compose up -d`.

Otherwise you might have to change the contents of `config/database.yml` to make the application run.

Run the following commands:
```bash
$ yarn install --check-files
$ bundle install
$ rails db:prepare
$ rails s
```

You should have the app running by now.

For running tests you may have to install a chromium browser.

### Contributing

Bug reports and pull requests are highly welcomed and appreciated. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

1. Fork the repository
2. Create your feature branch by branching off of **main** (`git checkout -b my-new-feature`)
3. Make your changes
4. Make sure all tests run successfully (`rails test:all` and `NOJS=1 rails test:all`)
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new pull request
