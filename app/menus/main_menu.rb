class MainMenu < MenuMotion::Menu
  include ActionRows
  include ProjectRows
  include RoleRows
  include SessionActions
  include TaskRows
  include TimerRows

  def init
    start_update_timer
    self.delegate = self
    self
  end

  def build_loading_menu
    sections = [{
      rows: [{
        title: "Loading..."
      }]
    }, {
      rows: action_rows
    }]

    build_menu_from_params(self, { sections: sections })
  end

  def build_logged_in_menu
    sections = []

    # Build the rows for running timers
    unless timer_rows.empty?
      sections << {
        rows: timer_rows
      }
    end

    # Build row for Start Timer submenu
    sections << {
      rows: [{
        title: "Start Timer",
        tag:   self.roles.length > 1 ? "start-timer" : "role-#{self.roles.first.subscription_id}",
        rows:  self.roles.length > 1 ? role_rows : project_rows(self.roles.first)
      }]
    }

    # Build action rows
    sections += action_sections

    # Finally, build out the menu
    build_menu_from_params(self, { sections: sections })
  end

  def build_logged_out_menu
    params = {
      sections: [{
        rows: [{
          title: "Log In",
          target: self,
          action: "log_in"
        }]
      }, {
        rows: action_rows
      }]
    }
    build_menu_from_params(self, params)
  end

  def build_menu
    if Tick.logged_in?
      if self.roles
        build_logged_in_menu
      else
        build_loading_menu

        Tick::Role.list do |roles|
          if roles.is_a?(NSError)
            error = roles
            alert = NSAlert.alertWithError(error)
            alert.runModal
            Tick.log_out
            build_logged_out_menu
          else
            self.roles = roles.sort_by{|role|
              role.company.downcase
            }

            self.roles.each do |role|
              Tick::Session.current.api_token = role.api_token
              Tick::Session.current.subscription_id = role.subscription_id

              Tick::Client.list do |clients|
                role.clients = clients
                role.clients.each_with_index do |client, client_index|

                  Tick::Project.list(client_id: client.id) do |projects|
                    client.projects = projects.sort_by{|project| project.name.downcase }
                    client.projects.each_with_index do |project, project_index|
                      project.client = client

                      Tick::Task.list(project_id: project.id) do |tasks|
                        project.tasks = tasks.sort_by{|task| task.name.downcase }

                        tasks.each do |task|
                          task.project = project
                        end

                        if client_index == role.clients.length - 1 && project_index == client.projects.length - 1
                          self.performSelector("build_logged_in_menu", withObject: nil, afterDelay: 2)
                        end
                      end

                    end
                  end

                end
              end

            end
          end
        end
      end
    else
      build_logged_out_menu
    end
    NSApplication.sharedApplication.delegate.update_status_item
  end

  def build_menu_from_params(root_menu, params)
    self.removeAllItems
    super
  end

  def start_update_timer
    @update_timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "build_menu", userInfo: nil, repeats: true)
    @update_timer.setTolerance(10)
    @update_timer.fire
  end

end
