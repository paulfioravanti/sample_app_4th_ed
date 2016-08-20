if ENV["TRAVIS"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
else
  unless ENV["NO_COVERAGE"]
    # NOTE: SimpleCov doesn't seem to play nice with Rails 5 at the moment.
    SimpleCov.start 'rails'
  end
end
