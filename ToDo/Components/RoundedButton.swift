//
//  RoundedButton.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-28.
//

import UIKit

class RoundedButton: UIButton {

  override func awakeFromNib() {
    super .awakeFromNib()
    titleLabel?.font = UIFont.style(.body)
    backgroundColor = .link
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 5
  }
}
