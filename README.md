# Ruby on Rails Tutorial sample application
[![Build Status](https://travis-ci.org/paulfioravanti/sample_app_4th_ed.svg?branch=master)](https://travis-ci.org/paulfioravanti/sample_app_4th_ed) [![Code Climate](https://codeclimate.com/github/paulfioravanti/sample_app_4th_ed/badges/gpa.svg)](https://codeclimate.com/github/paulfioravanti/sample_app_4th_ed) [![Test Coverage](https://codeclimate.com/github/paulfioravanti/sample_app_4th_ed/badges/coverage.svg)](https://codeclimate.com/github/paulfioravanti/sample_app_4th_ed/coverage) [![Issue Count](https://codeclimate.com/github/paulfioravanti/sample_app_4th_ed/badges/issue_count.svg)](https://codeclimate.com/github/paulfioravanti/sample_app_4th_ed)

This is the sample application for
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).

## License

All source code in the [Ruby on Rails Tutorial](http://railstutorial.org/)
is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For more information, see the
[*Ruby on Rails Tutorial* book](http://www.railstutorial.org/book).
