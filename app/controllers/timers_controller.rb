class TimersController
  attr_accessor :current_project, :current_task, :current_timer, :running
  
  def pause_timer
    self.running = false
    
    self.current_timer.stop
    build_main_menu
    
    @update_timer.fire
    @update_timer.invalidate
  end
  
  def submit_entry
    task_id = self.current_task.id
    hours = self.current_timer.elapsed_time_in_hours.round(2)
    
    formatter = NSDateFormatter.new
    formatter.dateFormat = "yyyy-MM-dd"
    date_string = formatter.stringFromDate(Time.now)
    
    Tick::Entry.create(
      task_id: task_id,
      hours: hours,
      date: date_string
    ).then(lambda{|xml|
      ap "#{self.current_project.name} - #{self.current_task.name} - Hours: #{hours}"
      self.reset
    })
  end
  
  def reset
    @update_timer.invalidate
    self.current_project = nil
    self.current_task = nil
    self.current_timer = nil
    self.running = nil
    build_main_menu
  end
  
  def start_timer(project=nil, task=nil)
    self.running = true
    
    if self.current_timer
      self.current_timer.start
    else
      self.current_project = project
      self.current_task = task
      self.current_timer = Timer.new
    end
    build_main_menu
    
    @update_timer = NSTimer.scheduledTimerWithTimeInterval(10, target:self, selector:"update_menu_timer", userInfo:nil, repeats:true)
    @update_timer.setTolerance(10)
    @update_timer.fire
  end
  
  def self.instance
    @instance ||= new
  end
  
private
  
  def build_main_menu
    main_menu.build_menu
    update_menu_icon
  end
  
  def main_menu
    NSApplication.sharedApplication.delegate.main_menu
  end
  
  def update_menu_icon
    status_item = NSApplication.sharedApplication.delegate.status_item
    status_image = NSImage.imageNamed(self.running ? "stopwatch-filled.pdf" : "stopwatch.pdf")
    status_item.setImage(status_image)
    alt_status_image = NSImage.imageNamed(self.running ? "stopwatch-filled-alt.pdf" : "stopwatch-alt.pdf")
    status_item.setAlternateImage(alt_status_image)
  end
  
  def update_menu_timer
    title = "#{self.current_project.name} - #{self.current_task.name} - #{self.current_timer.displayed_time}"
    title += " - Paused" unless self.running
    main_menu.running_timer_item.title = title
  end
  
end