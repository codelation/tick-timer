module ProjectRows
  attr_accessor :projects

  def project_rows
    self.projects.map{|project|
      {
        title: project.name,
        rows: project.tasks.map{|task|
          {
            title: task.name,
            object: task,
            tag: "task_#{task.id}",
            target: self,
            action: "start_timer:"
          }
        }
      }
    }
  end

  def start_timer(menu_item)
    task = menu_item.object
    timer = Tick::Timer.start_with_task(task)
  end

end
