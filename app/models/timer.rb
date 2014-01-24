class Timer
  attr_accessor :displayed_time, :start_time, :time_spans
  
  def displayed_time
    hours = self.elapsed_time_in_hours.to_i
    minutes = (self.elapsed_time_in_seconds / 60).to_i - (hours * 60)
    
    hours = hours.to_s
    hours = "0#{hours}" if hours.length == 1
    
    minutes = minutes.to_s
    minutes = "0#{minutes}" if minutes.length == 1
    
    "#{hours}:#{minutes}"
  end
  
  def elapsed_time_in_seconds
    elapsed_time_in_seconds = 0
    self.time_spans.each do |seconds|
      elapsed_time_in_seconds += seconds
    end
    
    if self.start_time
      elapsed_time_in_seconds += Time.now - self.start_time
    end
    elapsed_time_in_seconds
  end
  
  def elapsed_time_in_hours
    self.elapsed_time_in_seconds / 60 / 60
  end
  
  def initialize
    self.start
  end
  
  def start
    self.start_time = Time.now
  end
  
  def stop
    self.time_spans << Time.now - self.start_time
    self.start_time = nil
  end
  
  def time_spans
    @time_spans ||= []
  end
  
end