//
//  NewTaskPopController.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-17.
//

import UIKit

protocol NewTaskDelegate: AnyObject {
  func closeModal()
}

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
      view.backgroundColor = .black.withAlphaComponent(0.9)
      nib.transform = CGAffineTransform(scaleX: 0, y: 0)
      view.addSubview(nib)
        // Do any additional setup after loading the view.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 0.25) {
      //self.nib.transform = CGAffineTransform(scaleX: 1, y: 1) //animation scaling to original size UIView.animate(withDuration: , animation: () -> ) linear way
      
      //self.nib.transform = CGAffineTransform.identity //does the same as above and the view is back to its original ignoring any transformations
      
//      UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) {
//        self.nib.transform = CGAffineTransform(scaleX: 1, y: 1)
//      } //animation scaling to original size UIView.animate(withDuration: , animation: () -> ) ease out way

      //same as the code above
      UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 15, options: [.curveEaseOut]) {
        self.nib.transform = CGAffineTransform(scaleX: 1, y: 1) // scalling to original set frame size which is 1
      } //giving natural bounce like a spring uding the Spring damping (the smaller number the bouns more noticable) and velocity (the bigger velocity the slower spring effect animation given 
      
    }
  }
    

  init(task: Task? = nil){
    super.init(nibName: nil, bundle: nil)
    modalTransitionStyle = .crossDissolve
    modalPresentationStyle = .overFullScreen
    self.task = task
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  

}

// MARK: - extentions
//extension NewTaskPopController: NewTaskNibDelegate {
//  func closeModal() {
//    dismiss(animated: true)
//  }
//}

extension NewTaskPopController: NewTaskDelegate {
  func closeModal() {
    dismiss(animated: true)
  }
}
