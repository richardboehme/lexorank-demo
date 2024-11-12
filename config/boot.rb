# frozen_string_literal: true

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
ENV["BOOTSNAP_IGNORE_DIRECTORIES"] ||= "node_modules,tmp,public,bin,.idea,.github,log"

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
