//
//  ShadowButton.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-28.
//

import UIKit

class ShadowButton: UIButton {

  
  
  override func awakeFromNib() {
    super .awakeFromNib()
    titleLabel?.font = UIFont.style(.body)
    backgroundColor = .link
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    layer.shadowOffset = CGSize(width: 0, height: 5) // bottom shadow
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 5
    layer.masksToBounds = false //to ensure the shadow will be present
    layer.shadowOpacity = 0.8
    layer.shadowRadius = 4 //for blur add to some number
    layer.shadowColor = UIColor.other.cgColor //set colour in extension assets or manually
    
  }
}
