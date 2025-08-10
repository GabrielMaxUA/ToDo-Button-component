//
//  TaskViewCell.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-17.
//

import UIKit

protocol TaskViewCellDelegate: AnyObject {
  func editTask(id: String)
  func isComplete(id: String, isComplete: Bool)
}

class TaskViewCell: UITableViewCell {

  static let identifier = "TaskCell"
  
  @IBOutlet weak var cellBox: UIView!
  @IBOutlet weak var categoryBox: UIView!
  @IBOutlet weak var caption: UILabel!
  @IBOutlet weak var taskDate: UILabel!
  @IBOutlet weak var taskCompleteImage: UIImageView!
  @IBOutlet weak var category: UILabel!
  @IBOutlet weak var categoryColor: UIView!
  
  private var task: Task!
  weak var delegate: TaskViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    let tap = UITapGestureRecognizer(target: self, action: #selector(isComplete))
    taskCompleteImage.addGestureRecognizer(tap)
    taskCompleteImage.isUserInteractionEnabled = true
    cellBox.layer.cornerRadius = 8
    categoryBox.layer.cornerRadius = 8
    cellBox.layer.masksToBounds = true
    caption.font = UIFont.style(.body)
    category.font = UIFont.style(.category)
    taskDate.font = UIFont.style(.secondaryText)
    
        // Initialization code
  }
  
    @objc func isComplete() {
    delegate?.isComplete(id: task.id, isComplete: task.isCompleted)
  }
  
  @IBAction func editTapped(_ sender: Any) {
    delegate?.editTask(id: task.id)
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }

  func configureWith(task: Task, delegate: TaskViewCellDelegate) {
    self.task = task
    let formatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      formatter.timeStyle = .medium
      return formatter
    }()
    self.delegate = delegate
    caption.text = task.caption
    taskDate.text = formatter.string(from: task.date)
    category.text = task.category.rawValue
    taskCompleteImage.image = task.isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
    categoryColor.backgroundColor = task.category.color // add () if functionally changing the color
    categoryBox.backgroundColor = task.category.secondaryColor
    category.textColor = task.category.color
  }
  
}
