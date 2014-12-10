module TaskRows

  def task_rows(role, project)
    Tick::Session.current.api_token = role.api_token
    Tick::Session.current.subscription_id = role.subscription_id

    Tick::Task.list(project_id: project.id) do |tasks|
      tasks = tasks.sort_by{|task| task.name.downcase }

      self.update_item_with_tag("project-#{project.id}", {
        rows: tasks.map{|task|
          task.project = project
          {
            title:  task.name,
            object: task,
            tag:    "task-#{task.id}",
            target: self,
            action: "start_timer:"
          }
        }
      })
    end

    []
  end

  def start_timer(menu_item)
    task = menu_item.object
    timer = Tick::Timer.start_with_task(task)
    build_menu
  end

end
