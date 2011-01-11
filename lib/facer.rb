#!/usr/bin/env ruby
require 'rubygems'

gem 'multipart-post'
gem 'mime-types'
gem 'json'

require "net/http"
require "net/http/post/multipart"
require 'mime/types'
require "uri"
require "json"

require "linker.rb"
require "facer/namespace.rb"
require "facer/account.rb"
require "facer/faces.rb"

# This class manage basilar operations on face.com.
# It's very alpha so you will find a very basical subset
# to use face.com services
# Author::    Stefano Valicchia  (mailto:stefano.valicchia@gmail.com)
# Copyright:: Copyright (c) 2011 Giano
# License::   Distributes under the same terms as Ruby
module Facer
  VERSION = "0.0.6"
end