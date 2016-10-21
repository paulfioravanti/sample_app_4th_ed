if ENV["TRAVIS"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end
unless ENV["NO_COVERAGE"]
  SimpleCov.start("rails") do
    add_filter "/app/channels/"
    add_filter "/app/jobs/"
  end
end
