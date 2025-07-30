//
//  ThemeModeController.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-25.
//

import UIKit

class ThemeModeController: UIViewController {
  @IBOutlet weak var themeHeadLabel: UILabel!
  @IBOutlet weak var appTheme: UILabel!
  @IBOutlet weak var settingsModal: UIView!
  @IBOutlet var settingsView: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      themeHeadLabel.font = UIFont.style(.category)
      appTheme.font = UIFont.style(.caption)
      settingsModal.backgroundColor = .secondarySystemBackground
//      settingsView.backgroundColor = .systemBackground.withAlphaComponent(0.95) //change it in storyBoard or programmatically here
    }
    
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    settingsModal.layer.cornerRadius = 10
  }
  
  @IBAction func closeSettingstapped(_ sender: Any) {
    dismiss(animated: true)
  }
  
  @IBAction func themeModeTapped(_ sender: UISegmentedControl) {
    //uiapplication -> including:
    //windowscenes ->
    //windows ->
    //key window ->
    //overrideUserINterfaceStyle (thats where we are changing the theme in
    let window = UIApplication.shared.connectedScenes.flatMap {($0 as? UIWindowScene)?.windows ?? [] }.first {$0.isKeyWindow} //looking for scenes in the app with flatMap (returns array) while compactMap(returns array of array)
    if sender.selectedSegmentIndex == 0 {
      window?.overrideUserInterfaceStyle = .light //UIUserInterfaceStyle.light
    }
    else if sender.selectedSegmentIndex == 1 {
      window?.overrideUserInterfaceStyle = .dark
    }
    else {
      window?.overrideUserInterfaceStyle = .unspecified
    }
  }
  

}
