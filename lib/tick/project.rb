# class TickStub
#   
#   def initialize(app)
#     @app = app
#   end
#  
#   def call(request)
#     status, headers, data = @app.call(request)
#     
#     if request.URL.absoluteString.start_with? "https://81designs.tickspot.com/api/projects"
#       ap "URL: #{request.URL.absoluteString}"
#       ap data
#       data = File.open("#{NSBundle.mainBundle.resourcePath}/projects.xml").read.to_data
#     end
#  
#     return status, headers, data
#   end
#   
# end
#  
# RackMotion.use TickStub

module Tick
  
  class Project
    attr_accessor :id, :name, :tasks
    
    def self.authentication_controller
      Tick::AuthenticationController.instance
    end
    
    def self.list(options={})
      url  = "https://#{authentication_controller.company}.tickspot.com/api/projects"
      
      params = {
        email: authentication_controller.email,
        password: authentication_controller.password
      }
      
      params.merge! options
    
      promise = Loco::Promise.new
      
      AFMotion::XML.get(url, params) do |result|
        if result.success?
          projects = []
          
          # Parse XML
          error = Pointer.new(:object)
          xml = GDataXMLDocument.alloc.initWithXMLString(result.body, error:error)
          
          # Create the project objects
          error = Pointer.new(:object)
          project_nodes = xml.nodesForXPath("//project", error:error)
          
          project_nodes.each do |project_node|
            project = Project.new
            project.id = project_node.elementsForName("id").first.stringValue.intValue
            project.name = project_node.elementsForName("name").first.stringValue
            project.tasks = []
            task_nodes = project_node.elementsForName("task")
            task_nodes.each do |task_node|
              task = Task.new
              task.id = task_node.elementsForName("id").first.stringValue.intValue
              task.name = task_node.elementsForName("name").first.stringValue
              project.tasks << task
            end
            projects << project
          end
          
          promise.resolve(projects)
        elsif result.failure?
          authentication_controller.logout
          promise.reject(result.error)
        end
      end
    
      promise
    end
    
  end
  
end