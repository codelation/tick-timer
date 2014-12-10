module ProjectRows

  def project_rows(role)
    Tick::Session.current.api_token = role.api_token
    Tick::Session.current.subscription_id = role.subscription_id

    Tick::Project.list do |projects|
      projects = projects.sort_by{|project| project.name.downcase }

      self.update_item_with_tag("role-#{role.subscription_id}", {
        rows: projects.map{|project|
          {
            title: project.name,
            tag:   "project-#{project.id}",
            rows:  task_rows(role, project)
          }
        }
      })
    end

    []
  end

end
