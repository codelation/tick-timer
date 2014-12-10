module TaskRows

  def task_rows(project)
    project.tasks.map{|task|
      task.project = project
      {
        title:  task.name,
        object: task,
        tag:    "task-#{task.id}",
        target: self,
        action: "start_timer:"
      }
    }
  end

  def start_timer(menu_item)
    task = menu_item.object
    timer = Tick::Timer.start_with_task(task)
    build_menu
  end

end
