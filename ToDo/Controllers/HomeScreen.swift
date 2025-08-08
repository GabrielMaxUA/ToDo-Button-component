//
//  ViewController.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-17.
//

import UIKit
import os
///Our main controller when the app is launched. Starting point where all controllers and views are connected to
class HomeScreen: UIViewController {

  //creating a button programmaticly so it would be over the app content (tableView in our case) to be able to add new task
  lazy var button: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    //scaling our button image("+") for better visibility
    button.imageView?.layer.transform = CATransform3DMakeScale(1.4, 1.4, 1.4)
    button.backgroundColor = .systemBlue
    button.tintColor = .white
    button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    return button
  }()
  
  let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
  }()
  
  var tasks: [Task] = []
  
  @IBOutlet weak var appTitle: UIView!
  @IBOutlet weak var appDate: UILabel!
  @IBOutlet weak var appName: UILabel!
  @IBOutlet weak var taskTable: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(button)
    setupView()
    notificationHub()
  }
  
  //styling our button to dd new task and positioning it in the screen
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let width: CGFloat = 50
    let height: CGFloat = 50
    let x = ( view.frame.width - width ) / 2
    let y = view.frame.height - height - view.safeAreaInsets.bottom
    button.layer.cornerRadius = height / 2
    button.frame = CGRect(x: x, y: y, width: width, height: height)
    
  }
  
  //setting up the content in the controller
  private func setupView() {
    appTitle.layer.cornerRadius = 20
    appTitle.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    appTitle.clipsToBounds = true
    appDate.text = formatter.string(from: Date())
    taskTable.dataSource = self
    appDate.text = formatter.string(from: Date())
    taskTable.separatorStyle = .none
    appName.font = UIFont.style(.category)
    appDate.font = UIFont.style(.caption)
   
  }
  
  /// Notification center to recieve notifications from other controller (NewTaskNib)
  private func notificationHub() {
    NotificationCenter.default.addObserver(self, selector: #selector(addNewTask(_:)), name: NSNotification.Name("NewTask"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(updateTask(_:)), name: NSNotification.Name("UpdatedTask"), object: nil)
  }

  /**
   Function to populate the table with new task table cell with userInfo recieved from NewTaskNib
   - Parameters:
      - notification: notification recieved from NewTaskNib for NewTask
      
   */
  @objc func addNewTask(_ notification: Notification) {
    os_log("New task notification recieved", type: .info)
    print("LOG_INFO: New task recieved by notification observer")
    if let userInfo = notification.userInfo, let task = userInfo["NewTask"] as? Task {
      tasks.append(task)
      taskTable.reloadData()
      os_log("New task added to the array", type: .info)
      print("LOG_INFO: New task added to the array")
    }
  }
  
  /**
   Function to update the table with edited task table cell with userInfo recieved from NewTaskNib
   - Parameters:
      - notification: notification recieved from NewTaskNib for UpdatedTask
   */
  @objc func updateTask(_ notification: Notification) {
    if let userInfo = notification.userInfo, let updatedTask = userInfo["UpdatedTask"] as? Task {
      if let taskIndex = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
          tasks[taskIndex] = updatedTask
        taskTable.reloadData()
      }
    }
  }
  
  /// Trigger to open NewTaskViewController with NewTaskNib to create a new task
  
  @objc func addTapped() {
    let newTaskVC = NewTaskPopController()
    present(newTaskVC, animated: true)
  }
  
  @IBAction func themeMode(_ sender: Any) {
    performSegue(withIdentifier: "settings", sender: nil) //no passing any data so just nil
  }
  
  
}

// MARK: - extensions
extension HomeScreen: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskViewCell.identifier, for: indexPath) as? TaskViewCell ?? TaskViewCell()
    let task = tasks[indexPath.row]
    cell.configureWith(task: task, delegate: self)
    return cell
  }
 //deleting with swipe
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tasks.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}


/// Extension of TaskViewCell where we pass the data to be able to trigger NewTaskPopController to edit task or to toggle image inside the cell
extension HomeScreen: TaskViewCellDelegate {
  
  /** triggering the NewTaskPopController and passing the task to it which populates NewTaskNib with all task info to be edited
   - Parameters:
    -  task: is the tapped (ellipsis button inside the taskViewCell) task id passed to controller
    after editing the task in the nib the data passed here via notificationHub and repopulating the cell with new data and reloading the view to reflect changes in it
   */
  func editTask(id: String) {
    let task = tasks.first { task in
      task.id == id
    }
    let newTaskVC = NewTaskPopController(task: task)
    present(newTaskVC, animated: true)
  }
  
  /** toggling taskCell image when user tapps it if task is complete where
   - Parameters:
      - id is the tapped taskCell Id serached through the tasks array by task index
      - isComplete a bolean set in TaskViewCell using the configure method to toggle the image 
   */
  func isComplete(id: String, isComplete: Bool) {
    let taskIndex = tasks.firstIndex { task in
      task.id == id
    }
    guard let index = taskIndex else { return }
    tasks[index].isCompleted.toggle()
    taskTable.reloadData()
  }
  
  
}


