module Facer
  # Base class to store informations and obtain infos on the namespace
  class Namespace
    attr_reader :name
    attr_reader :size
    attr_reader :shareMode
    attr_reader :owner
    
     # Initialize the class passing a convenient linker reference and infos about the namespace
    def initialize(linker,name,size,shareMode,owner)
      @linker=linker
      @name=name
      @size=size
      @shareMode=shareMode
      @owner=owner
    end
    
    # Retrieve namespace's user list
    def users?
      if(@owner && @shareMode==:Private)
        t_users=@linker.call("account","users",{"namespaces" => @name})
        out=[]
        if(t_users["status"].to_sym == :success)
           t_users["users"].each_pair do |key,namespace_users|
              out+=namespace_users
           end
           return out
        else
          return []
        end
      else
        return []
      end
      namespaces?.reject {|key,value| !value.owner}
    end
    
    private
    attr_accessor :linker
  end
end