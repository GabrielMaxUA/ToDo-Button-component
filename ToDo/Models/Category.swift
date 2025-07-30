//
//  Category.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-17.
//

import Foundation
import UIKit

enum Category: String, CaseIterable {
  case work = "Work"
  case personal = "Personal"
  case shopping = "Shopping"
  case health = "Health"
  case other = "Other"
  
  
  var color: UIColor {
    switch self {
      case .work:
        return UIColor.work
      case .personal:
        return UIColor.personal
      case .shopping:
        return UIColor.shopping
      case .health:
        return UIColor.health
      case .other:
        return UIColor.other
      }
  
  }
  
  var secondaryColor: UIColor {
     switch self {
     case .work:
       return UIColor.work.withAlphaComponent(0.15)
     case .personal:
       return UIColor.personal.withAlphaComponent(0.15)
     case .shopping:
       return UIColor.shopping.withAlphaComponent(0.15)
     case .health:
       return UIColor.health.withAlphaComponent(0.15)
     case .other:
       return UIColor.other.withAlphaComponent(0.15)
     }
   }
  
  
  
  
  //functionally setting color
//  func color() -> UIColor {
//    switch self {
//    case .work:
//      return UIColor.work
//    case .personal:
//      return UIColor.personal
//    case .shopping:
//      return UIColor.shopping
//    case .health:
//      return UIColor.health
//    case .other:
//      return UIColor.other
//    }
//  }
  
}


