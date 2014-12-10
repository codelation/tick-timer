module RoleRows
  attr_accessor :roles

  def role_rows
    self.roles.map{|role|
      {
        title: role.company,
        tag:   "role-#{role.subscription_id}",
        rows:  client_rows(role)
      }
    }
  end

end
