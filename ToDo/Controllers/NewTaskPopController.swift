//
//  NewTaskPopController.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-17.
//

import UIKit

// TODO: - move to separate protocol file/class in the app in the future

/// NewTaskDelegate linkes this controller to NewTaskNib to help with dismiss on x-button tapped and to show alert if caption isnt met requerments

protocol NewTaskDelegate: AnyObject {
  //closing NewTaskNib
  func closeModal()
  
  /** Showing alert on caption error
   - Parameters:
      -title: title of the alert
      -message: alert message
        all set in NewTaskNib
  */
  func errorAlert(title: String, message: String)
}

/// Creating or editing task with popUp nib inside It

class NewTaskPopController: UIViewController {
  private var task: Task?

  
  lazy var nib: NewTaskNib = {
    let width = view.frame.width - 30
    let height: CGFloat = 505
    let y = view.center.y - height / 2
    let frame: CGRect = CGRect(x: 15, y: y, width: width, height: height)
    let nib = NewTaskNib(frame: frame, task: task)
    nib.delegate = self
    return nib
  }()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .black.withAlphaComponent(0.5)
      
      // scaling nib to 0 to animate its appearance in ViewDidAppear
      nib.transform = CGAffineTransform(scaleX: 0, y: 0)
      view.addSubview(nib)
        // Do any additional setup after loading the view.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //using the animation mentioned for UIView (our NewTaskNib) appearance in extention in Design/Animations
    nib.scaleUpAnimation()
  }
    
  /**
   This init creates a new task NewTaskPopController
   - Parameters:
      - task: if task edited then task must be passed. and if New task created no task to be passed as a parameter (nil)
      - returns: NewTaskPopController with NewTaskNib for adding or editing a task
   */

  init(task: Task? = nil){
    super.init(nibName: nil, bundle: nil)
    modalTransitionStyle = .crossDissolve
    modalPresentationStyle = .overFullScreen
    self.task = task
  }
  
  //FIXME: - look into this in the future
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  

}

// MARK: - extentions

extension NewTaskPopController: NewTaskDelegate {
  func errorAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) //closing on ok tap
    alert.addAction(okAction)
    present(alert, animated: true)
  }
  
  func closeModal() {
    dismiss(animated: true)
  }
}
