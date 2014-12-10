module ProjectRows

  def project_rows(role)
    role.clients.map(&:projects).flatten.map{|project|
      {
        title: "#{project.client.name} - #{project.name}",
        tag:   "project-#{project.id}",
        rows:  task_rows(project)
      }
    }
  end

end
