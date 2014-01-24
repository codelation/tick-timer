module Tick
  
  class Entry
    
    def self.create(options={})
      url  = "https://#{Tick::AuthenticationController.instance.company}.tickspot.com/api/create_entry"
      
      params = {
        email: Tick::AuthenticationController.instance.email,
        password: Tick::AuthenticationController.instance.password
      }
      
      params.merge! options
    
      promise = Loco::Promise.new
    
      AFMotion::XML.post(url, params) do |result|
        error = Pointer.new(:object)
        xml = XMLReader.dictionaryForXMLString(result.body, error:error)
        promise.resolve(xml)
      end
    
      promise
    end
    
  end
  
end