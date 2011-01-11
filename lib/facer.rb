#!/usr/bin/env ruby
$LOAD_PATH << './lib/facer'
require 'rubygems'

gem 'multipart-post'
gem 'mime-types'
gem 'json'

require "net/http"
require "net/http/post/multipart"
require 'mime/types'
require "uri"
require "json"

require "linker"
require "namespace"
require "account"
require "faces"

# This class manage basilar operations on face.com.
# It's very alpha so you will find a very basical subset
# to use face.com services
# Author::    Stefano Valicchia  (mailto:stefano.valicchiagmail.com)
# Copyright:: Copyright (c) 2002 Giano
# License::   Distributes under the same terms as Ruby
module Facer
  VERSION = "0.0.4"
end