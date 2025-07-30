//
//  Typography.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-23.
//

import Foundation
import UIKit

extension UIFont {
  
  convenience init(type: FontType, size: FontSize) {
    self.init(name: type.name, size: size.value)!
  }
  
  static func style(_ style: FontStyle) -> UIFont{
    return style.font
  }
  
}

 enum FontType: String {
   case assBold = "Assistant-Bold"
   case assSemiBold = "Assistant-SemiBold"
   case assMedium = "Assistant-Medium"
   case assRegular = "Assistant-Regular"
}

extension FontType {
  var name: String {
    return self.rawValue
  }
}

enum FontSize {
  
  case custom(Double)
  case theme(FontStyle)
}

extension FontSize {
  
  var value: Double {
    switch self {
    case .custom(let customSize):
      return customSize
    case .theme(let size):
      return size.size
    }
  }
  
}

enum FontStyle{
  
  case category
//  case h1
//  case h2
//  case h3
  case body
  case caption
  case secondaryText
  
}

extension FontStyle {
  
  var size: Double {
    switch self {
//    case .h1:
//      return 32
//    case .h2:
//      return 26
    case .category:
      return 22
    case .body:
      return 16
    case .caption:
      return 12
    case .secondaryText:
      return 14
    }
  }
  
  private var fontDesctiption: FontDescription {
    switch self {
    case .category:
      return FontDescription(font: .assBold, size: .theme(.category), style: .title1)
//    case .h1:
//      return FontDescription(font: .assSemiBold, size: .theme(.h1), style: .title2)
//    case .h2:
//      return FontDescription(font: .assSemiBold, size: .theme(.h2), style: .title2)
//    case .h3:
//      return FontDescription(font: .assRegular, size: .theme(.h3), style: .title3)
    case .body:
      return FontDescription(font: .assRegular, size: .theme(.body), style: .body)
    case .caption:
      return FontDescription(font: .assMedium, size: .theme(.caption), style: .caption1)
    case .secondaryText:
      return FontDescription(font: .assRegular, size: .theme(.secondaryText), style: .body)
    }
  }
  
  var font: UIFont {
    guard let font = UIFont(name: fontDesctiption.font.name, size: fontDesctiption.size.value) else {
      return UIFont.preferredFont(forTextStyle: fontDesctiption.style)
    }
    let fontMetrics = UIFontMetrics(forTextStyle: fontDesctiption.style)
    return fontMetrics.scaledFont(for: font)
  }
  
}


private struct FontDescription {
  let font: FontType
  let size: FontSize
  let style: UIFont.TextStyle
}


// MARK: - EXPLANATION OF THE CODE ABOVE

//What This Code Does

//Main Purpose: Instead of scattered font code throughout your app, this creates a centralized system where you can say "give me an H1 heading" and it automatically provides the right font, size, and styling.
//Breaking Down Each Part


//1. UIFont Extension (The Main Interface)
//swiftextension UIFont {
//  convenience init(type: FontType, size: FontSize) {
//    self.init(name: type.name, size: size.value)!
//  }
//  
//  static func style(_ style: FontStyle) -> UIFont{
//    return style.font
//  }
//}
//What it does: Adds two new ways to create fonts:
//
//UIFont(type: .assBold, size: .custom(18)) - Create a font with specific type and size
//UIFont.style(.h1) - Get a pre-configured heading style



//2. FontType Enum (The Font Families)
//swiftenum FontType: String {
//  case assBold = "Assistant-Bold"
//  case assSemiBold = "Assistant-SemiBold"
//  case assMedium = "Assistant-Medium"
//  case assRegular = "Assistant-Regular"
//}
//What it does: Defines the different weights of the "Assistant" font family available in the app. Instead of remembering exact font names like "Assistant-Bold", you just use .assBold.


//3. FontSize Enum (Flexible Sizing)
//swiftenum FontSize {
//  case custom(Double)
//  case theme(FontStyle)
//}
//What it does: Gives you two ways to specify font size:
//
//.custom(20) - Use any specific size you want
//.theme(.h1) - Use the predefined size for that style (H1 = 32pts)


//4. FontStyle Enum (The Style Library)
//swiftenum FontStyle{
//  case h1      // 32pt - Big headings
//  case h2      // 26pt - Medium headings
//  case h3      // 22pt - Small headings
//  case body    // 16pt - Regular text
//  case caption // 12pt - Small text
//  case secondaryText // 14pt - Less important text
//}
//What it does: Defines your app's text hierarchy - like a style guide that says "H1 is for main titles, body is for paragraphs, etc."


//5. FontStyle Extension (The Smart Part)
//This is where the magic happens. Each style (h1, h2, etc.) gets:
//
//A specific size (32, 26, 22, etc.)
//A specific font weight (though there's a bug here - it references .gontBlack etc. which aren't defined)
//Accessibility support - the font automatically scales if users increase text size in iOS settings


//How You'd Use This
//Instead of writing this messy code everywhere:
//swiftlet titleLabel = UILabel()
//titleLabel.font = UIFont(name: "Assistant-Bold", size: 32)
//You can write clean, meaningful code:
//swiftlet titleLabel = UILabel()
//titleLabel.font = UIFont.style(.h1)
//The Problem (Bug Alert!)
//There's an issue in the code - the fontDesctiption property references font types like .gontBlack, .gontSemiBold that don't exist in the FontType enum. This will cause crashes. It should probably use the Assistant fonts that are actually defined.


//Real-World Benefits
  
//Consistency - All H1 headings look exactly the same
//Easy Changes - Want to change all body text from 16pt to 18pt? Change it in one place
//Accessibility - Text automatically scales for users with vision needs
//Clean Code - UIFont.style(.h1) is much clearer than remembering font names and sizes

//This is a common pattern in professional iOS apps to maintain design consistency and make the codebase easier to maintain.
