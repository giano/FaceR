require "net/http"
require "net/http/post/multipart"
require 'mime/types'
require "uri"
require "json"
module Facer
  
 # This class hold the main linkage to face.com
 # acting as a gateway to subclasses
  class Linker
    # The main uri to face.com api.
    FaceComURI="http://api.face.com/"
    
    attr_reader :account
    attr_reader :faces
    
    # Initialize the linker with security informations
    def initialize(applicationName,key,secret)  
      @account=Account.new(self,applicationName,key,secret)
      @faces=Faces.new(self)
    end
    
    # Call the service appending security informations to every request
    def call(bclass,method,params = {},files = nil)
      params ||={}
      params["api_key"]=@account.apiKey
      params["api_secret"]=@account.apiSecret
      resp=callAPI(bclass,method,params,files)
      return resp
    end
    
    private
    # Call the service using post or multiform data for sending files and transpose to json the response
    def callAPI(bclass,method,params,files)
      uri=URI.parse("#{FaceComURI}#{bclass}/#{method}.json")
      params ||= {}
      if(files)
        files.each_pair do |name,path|
          params[name]=UploadIO.new(path, MIME::Types.type_for(path))
        end
        req = Net::HTTP::Post::Multipart.new(uri.path,params)
        res = Net::HTTP.start(uri.host, uri.port) do |http|
          http.request(req)
        end
        return JSON.parse(res.body)
      else
        res = Net::HTTP.post_form(uri,params)
        return JSON.parse(res.body)
      end
    end
  end
end