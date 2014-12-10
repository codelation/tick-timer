module ProjectRows

  def project_rows(role)
    role.projects.map{|project|
      {
        title: project.name,
        tag:   "project-#{project.id}",
        rows:  task_rows(project)
      }
    }
  end

end
