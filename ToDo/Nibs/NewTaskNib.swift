//
//  NewTaskNib.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-17.
//

import UIKit

//protocol NewTaskNibDelegate: AnyObject {
//  func closeModal()
//}

class NewTaskNib: UIView {
  
  @IBOutlet private var nibBox: UIView!
  @IBOutlet private weak var captionTextView: UITextView!
  @IBOutlet private weak var picker: UIPickerView!
  @IBOutlet weak var submitButton: RoundedButton!
  @IBOutlet private weak var nibTitle: UILabel!
  
  
  private var task: Task?
  weak var delegate: NewTaskDelegate?

  var caption: String{
    get { return captionTextView.text}
    set { captionTextView.text = newValue }
  }
  
  init(frame: CGRect, task: Task?) {
    super.init(frame: frame)
    self.task = task
    let nib = UINib(nibName: "NewTaskNib", bundle: nil)
    nib.instantiate(withOwner: self)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func commonInit() {
    addSubview(nibBox)
    nibBox.frame = bounds
    picker.delegate = self
    picker.dataSource = self
    captionTextView.delegate = self
    nibTitle.font = UIFont.style(.category)
    captionTextView.font = UIFont.style(.body)
    //submitButton.titleLabel?.font = UIFont.style(.body) //moved to roundedButton component
    captionTextView.layer.borderWidth = 0.5
    captionTextView.layer.borderColor = UIColor.lightGray.cgColor
    if let task = task {
      nibTitle.text = "Edit Task"
      let categoryIndex = Category.allCases.firstIndex(of: task.category)!
      picker.selectRow(categoryIndex, inComponent: 0, animated: false)
      caption = task.caption
      captionTextView.textColor = UIColor.label
      submitButton.setTitle("Update", for: .normal)
//      submitButton.titleLabel?.font = UIFont.style(.body)//fo system buttons we need to reset the font again for UIKIT would not override the font/ easiest way to avoid this when button is modified is to set button to custom so uikit wont kick in to override things over your settings in the storyboard(or programatically)
    } else {
      submitButton.setTitle("Add Task", for: .normal)
      /*submitButton.titleLabel?.font = UIFont.style(.body)*/ //fo system buttons we need to reset the font again for UIKIT would not override the font
      captionTextView.textColor = .placeholderText
      caption = "Enter a task description..."
    }
    
  }
  
  override func layoutSubviews() {
    nibBox.layer.cornerRadius = 10
    captionTextView.layer.cornerRadius = 5
    // submitButton.layer.cornerRadius = 5 //moved to roundedButton component
  }
  
  @IBAction func closeModal(_ sender: Any) {
    delegate?.closeModal()
  }
  
  @IBAction func SubmitTapped(_ sender: Any) {
    let id = UUID().uuidString
    guard let caption = captionTextView.text, caption.count >= 4 , captionTextView.textColor != .placeholderText else { return }
    let categoryIndex = picker.selectedRow(inComponent: 0)
    let category = Category.allCases[categoryIndex]
    
    if let task = task {
      let updatedTask = Task(id: task.id, category: category, caption: caption, date: task.date, isCompleted: false)
      let userInfo: [String: Task] = ["UpdatedTask": updatedTask]
      NotificationCenter.default.post(name: NSNotification.Name("UpdatedTask"), object: nil, userInfo: userInfo)
    }
    else{
      let newTask = Task(id: id, category: category, caption: caption, date: Date(), isCompleted: false)
      let userInfo: [String: Task] = ["NewTask": newTask]
      NotificationCenter.default.post(name: NSNotification.Name("NewTask"), object: nil, userInfo: userInfo)
    }
    delegate?.closeModal()
  }
}

// MARK: - extensions
extension NewTaskNib: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return Category.allCases.count
  }
}

extension NewTaskNib: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var label: UILabel? = view as? UILabel
    if label == nil {
      label = UILabel()
      label?.textAlignment = .center
      label?.textColor = .secondaryLabel
      label?.font = UIFont.style(.category)
    }
    label?.textAlignment = .center
    label?.textColor = .secondaryLabel
    label?.font = UIFont.style(.category)
    label?.text = Category.allCases[row].rawValue
    return label!
  }
}

extension NewTaskNib: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .placeholderText && textView.text == "Enter a task description..." {
      textView.text = ""
      textView.textColor = UIColor.label
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if !textView.text.isEmpty && textView.text.count >= 4 {
      textView.textColor = UIColor.label
    } else {
      textView.textColor = .placeholderText
      textView.text = "Enter a task description..."
    }
  }
}

// MARK: - checking repo commit
