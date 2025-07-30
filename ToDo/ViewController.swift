//
//  ViewController.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-17.
//

import UIKit

class ViewController: UIViewController {

  lazy var button: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "plus"), for: .normal)
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
    appTitle.layer.cornerRadius = 20
    appTitle.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    appTitle.clipsToBounds = true
    appDate.text = formatter.string(from: Date())
    taskTable.dataSource = self
    appDate.text = formatter.string(from: Date())
    taskTable.separatorStyle = .none
    appName.font = UIFont.style(.category)
    appDate.font = UIFont.style(.caption)
    NotificationCenter.default.addObserver(self, selector: #selector(addNewTask(_:)), name: NSNotification.Name("NewTask"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(updateTask(_:)), name: NSNotification.Name("UpdatedTask"), object: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let width: CGFloat = 50
    let height: CGFloat = 50
    let x = ( view.frame.width - width ) / 2
    let y = view.frame.height - height - view.safeAreaInsets.bottom
    button.layer.cornerRadius = height / 2
    button.frame = CGRect(x: x, y: y, width: width, height: height)
    
  }

  @objc func addNewTask(_ notification: Notification) {
    if let userInfo = notification.userInfo, let task = userInfo["NewTask"] as? Task {
      tasks.append(task)
      taskTable.reloadData()
    }
  }
  
  @objc func updateTask(_ notification: Notification) {
    if let userInfo = notification.userInfo, let updatedTask = userInfo["UpdatedTask"] as? Task {
      if let taskIndex = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
          tasks[taskIndex] = updatedTask
        taskTable.reloadData()
      }
    }
  }
  
  @objc func addTapped() {
    let newTaskVC = NewTaskPopController()
    present(newTaskVC, animated: true)
  }
  
  @IBAction func themeMode(_ sender: Any) {
    performSegue(withIdentifier: "settings", sender: nil) //no passing any data so just nil
  }
  
  
}

// MARK: - extensions
extension ViewController: UITableViewDataSource {
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

extension ViewController: TaskViewCellDelegate {
  func editTask(id: String) {
    let task = tasks.first { task in
      task.id == id
    }
    let newTaskVC = NewTaskPopController(task: task)
    present(newTaskVC, animated: true)
  }
  
  func isComplete(id: String, isComplete: Bool) {
    let taskIndex = tasks.firstIndex { task in
      task.id == id
    }
    guard let index = taskIndex else { return }
    tasks[index].isCompleted.toggle()
    taskTable.reloadData()
  }
  
  
}
