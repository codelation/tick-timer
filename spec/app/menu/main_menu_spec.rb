describe "MainMenu" do
  
  before do
    @app_name = NSBundle.mainBundle.infoDictionary["CFBundleDisplayName"]
    @main_menu = MainMenu.new
    @main_menu.build_menu
  end
  
  it "should be defined" do
    MainMenu.is_a?(Class).should.equal true
  end
  
  it "should have an about item" do
    @item_titles = @main_menu.itemArray.map(&:title)
    @item_titles.should.include "About #{@app_name}"
  end
  
  it "should have a quit item" do
    @item_titles.should.include "Quit"
  end
  
  it "should have a log in item when not logged in" do
    Tick.log_out
    @item_titles.should.include "Log In"
  end
  
  it "should have a log out item when logged in" do
    # Fake login
    session = Tick::Session.new
    session.company  = "company"
    session.email    = "email"
    session.password = "password"
    Tick::Session.instance_variable_set("@current", session)
    
    # Rebuild the menu
    @main_menu.build_menu
    @item_titles = @main_menu.itemArray.map(&:title)
    
    @item_titles.should.include "Log Out"
  end
  
  it "should have a start timer item when logged in" do
    @item_titles.should.include "Start Timer"
  end
  
  it "should have an item for each started timer" do
    project1 = Tick::Project.new
    project1.id = 1
    project1.name = "Project 1"
    
    task1 = Tick::Task.new
    task1.id = 1
    task1.name = "Task 1"
    task1.project = project1
    
    task2 = Tick::Task.new
    task2.id = 2
    task2.name = "Task 2"
    task2.project = project1
    
    project2 = Tick::Project.new
    project2.id = 2
    project2.name = "Project 2"
    
    task3 = Tick::Task.new
    task3.id = 3
    task3.name = "Task 3"
    task3.project = project2
    
    # Start new timer and rebuild the menu
    Tick::Timer.start_with_task(task1)
    @main_menu.build_menu
    @item_titles = @main_menu.itemArray.map(&:title)
    
    @item_titles.should.include "Project 1 - Task 1 - 00:00"
    
    # Start new timer and rebuild the menu
    Tick::Timer.start_with_task(task2)
    @main_menu.build_menu
    @item_titles = @main_menu.itemArray.map(&:title)
    
    @item_titles.should.include "Project 1 - Task 1 - 00:00 - Paused"
    @item_titles.should.include "Project 1 - Task 2 - 00:00"
    
    # Start new timer and rebuild the menu
    Tick::Timer.start_with_task(task3)
    @main_menu.build_menu
    @item_titles = @main_menu.itemArray.map(&:title)
    
    @item_titles.should.include "Project 1 - Task 1 - 00:00 - Paused"
    @item_titles.should.include "Project 1 - Task 2 - 00:00 - Paused"
    @item_titles.should.include "Project 2 - Task 3 - 00:00"
    
    # Clear a timer and rebuild the menu
    Tick::Timer.list.first.clear
    @main_menu.build_menu
    @item_titles = @main_menu.itemArray.map(&:title)
    
    @item_titles.should.not.include "Project 1 - Task 1 - 00:00 - Paused"
    @item_titles.should.not.include "Project 1 - Task 1 - 00:00"
    @item_titles.should.include "Project 1 - Task 2 - 00:00 - Paused"
    @item_titles.should.include "Project 2 - Task 3 - 00:00"
    @item_titles.should.not.include "Project 1 - Task 1 - 00:00 - Paused"
  end
  
end
