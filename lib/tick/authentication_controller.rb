class AuthenticationController
  attr_accessor :company, :email, :password
  
  SERVICE_NAME = "Tick Timer"
  
  def company
    storage.objectForKey("company")
  end
  
  def company=(value)
    storage.setObject(value, forKey:"company")
    storage.synchronize
    value
  end
  
  def email
    storage.objectForKey("email")
  end
  
  def email=(value)
    storage.setObject(value, forKey:"email")
    storage.synchronize
    value
  end
  
  def logged_in?
    (self.company && self.email && self.password) ? true : false
  end
  
  def login(company, email, password)
    url  = "https://#{company}.tickspot.com/api/users"
    
    params = {
      email: email,
      password: password
    }
    
    promise = Loco::Promise.new
  
    AFMotion::XML.get(url, params) do |result|
      if result.success?
        self.company = company
        self.email = email
        self.password = password
        promise.resolve(result.body)
      elsif result.failure?
        promise.reject(result.error)
      end
    end
    
    promise
  end
  
  def logout
    SSKeychain.deletePasswordForService(SERVICE_NAME, account:email)
  end
  
  def password
    SSKeychain.passwordForService(SERVICE_NAME, account:email)
  end
  
  def password=(value)
    SSKeychain.setPassword(value, forService:SERVICE_NAME, account:email)
  end
  
  def storage
    NSUserDefaults.standardUserDefaults
  end
  
  def self.instance
    @instance ||= new
  end
  
end