module Facer
  # Base class to query the api on faces and tags info
  # All the queries are in the "simplest form" of a single image/single user query
  # In this version of the gem I assume to use "single face" images
  # You can provide images as a file path or a public url, the library will treat them accordingly
  class Faces
    # Initialize the class passing a convenient linker reference
    def initialize(linker)
      @linker=linker
    end
    
    # Detect if the provided image contains a face and, if yes, return face's informations
    def detect(image,detector = :Normal)
      ret={}
      if(URI.parse(image).is_a?(URI::HTTP))
        ret=@linker.call("faces","detect",{"urls" => image, "detector" => detector.to_s})
      else
        ret=@linker.call("faces","detect",{"detector" => detector.to_s},{"upload" => image})
      end
      if(ret["status"].to_sym == :success && ret["photos"].length == 1)
        return ret["photos"][0]
      end
      return nil
    end
    
    # Force train a user against the images/tags library
    def train(user,namespace)
      ret=@linker.call("faces","train",{"uids" => "#{user}@#{namespace}"})
      return ret["status"].to_sym == :success
    end
    
    # Force train all users in a namespace (veeeery long operation)
    def train_all(namespace)
      namespaces=@linker.account.private_namespaces?
      if(!namespaces || !namespaces[namespace])
        return false
      end
      users=namespaces[namespace].users?
      success=true
      users.each do |user|
        success &= train(user,namespace)
      end
      return success
    end
    
    # Attempt to recognize a user in a image end, if so, provide user and face infos
    def recognize(image,namespace,users = "",detector = :Normal)
      if(users.empty?)
        users="all@#{namespace}"
      end
      ret={}
      if(URI.parse(image).is_a?(URI::HTTP))
        ret=@linker.call("faces","recognize",{"urls" => image, "uids" => users, "detector" => detector.to_s, "namespace" => namespace})
      else
        ret=@linker.call("faces","recognize",{"uids" => users, "detector" => detector.to_s, "namespace" => namespace},{"upload" => image})
      end 
      if(ret["status"].to_sym == :success && ret["photos"].length == 1)
        img=ret["photos"][0]
        if(img["tags"].length == 1)
           tag=img["tags"][0]
           if(tag["uids"] && tag["uids"].length>0)
             return tag["uids"][0]
           else
             return {"confidence" => 0, "uid" => nil}
           end
        else
           return {"confidence" => -1, "uid" => nil}
        end
      end
      return nil
    end
    
    # Associace many images to a user. I assume every images contains a single face
    def associate_multi(images,user,namespace, force_train = false, detector = :Normal)
      success=true
      images.each do |image|
        success &= associate(image,user,namespace,false,detector)
      end
      if(success && force_train)
         return train(user,namespace)
      end
      return success
    end
    
    # Associace a face image to a user. I assume the image contains a single face
    def associate(image,user,namespace, force_train = false, detector = :Normal)
      img=detect(image,detector)
      if(img && img["tags"].length == 1)
        tag=img["tags"][0]
        if(tag["attributes"]["face"] && tag["attributes"]["face"]["value"].to_s == "true")
          tid=tag["tid"]
          ret=@linker.call("tags","save",{"tids" => tid, "uid" => "#{user}@#{namespace}"})
          if(ret["status"].to_sym == :success)
            if(force_train)
              return train(user,namespace)
            end
            return true
          end
        end
      end
      return false
    end
    
    private
    attr_accessor :linker
  end
end