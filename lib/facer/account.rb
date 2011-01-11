module Facer
  # Base class to store security informations and obtain infos on the account
  class Account
    attr_reader :applicationName
    attr_reader :apiKey
    attr_reader :apiSecret
    
    # Initialize the class passing a convenient linker reference
    def initialize(linker, app_name,api_key,api_secret)
      @linker=linker
      @applicationName=applicationName
      @apiKey=key
      @apiSecret=secret
    end
    
    # Obtain all account's accessible namespaces
    def namespaces?
      t_namespaces=@linker.call("account","namespaces")
      if(t_namespaces["status"].to_sym == :success)
        out={}
        t_namespaces["namespaces"].each do |namespace|
          nm=Namespace.new(@linker,namespace["name"],namespace["size"],namespace["share_mode"].to_sym,namespace["owner"])
          out[nm.name]=nm
        end
        return out
      else
        return {}
      end
    end
    
    # Obtain all the namespaces owned by the account owner (public and private)
    def owned_namespaces?
      namespaces?.reject {|key,value| !value.owner}
    end
    
    # Obtain all account's private namespaces
    def private_namespaces?
      owned_namespaces?.reject {|key,value| value.shareMode!=:Private}
    end
    
    # Retrieve informations about current account's limits
    def limits?
      out=@linker.call("account","limits")
      if(out["status"].to_sym == :success)
        return out["usage"]
      else
        return nil
      end
    end
    
    private
    attr_accessor :linker
  end
end