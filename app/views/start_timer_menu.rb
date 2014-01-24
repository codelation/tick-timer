class StartTimerMenu < NSMenu
  
  def build_menu
    self.removeAllItems
    
    Tick::Project.list.then(lambda{|projects|      
      projects.each do |project|
        # Create menu item for each project
        project_menu = NSMenu.new
        project_menu_item = NSMenuItem.alloc.initWithTitle(project.name, action:nil, keyEquivalent:"")
        project_menu_item.setRepresentedObject(project)
        project_menu_item.setSubmenu(project_menu)
        
        # Create menu item for each task
        project.tasks.each do |task|
          task_menu_item = NSMenuItem.alloc.initWithTitle(task.name, action:"select_task:", keyEquivalent:"")
          task_menu_item.setTarget(self)
          task_menu_item.setRepresentedObject(task)
          project_menu.addItem(task_menu_item)
        end
        self.addItem(project_menu_item)
      end
    }, lambda{|error|
      self.supermenu.build_menu
    })
  end
  
  def select_task(sender)
    project = sender.parentItem.representedObject
    task = sender.representedObject
    self.delegate.start_timer(project, task)
  end
  
end