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
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      themeHeadLabel.font = UIFont.style(.category)
      appTheme.font = UIFont.style(.caption)
      settingsModal.backgroundColor = .secondarySystemBackground
      
      //detecting what mode device is on atm
      let window = UIApplication.shared.connectedScenes.flatMap {($0 as? UIWindowScene)?.windows ?? [] }.first {$0.isKeyWindow}
      if let window = window {
        switch window.overrideUserInterfaceStyle {
          case .light:
            segmentedControl.selectedSegmentIndex = 0
          case .dark:
            segmentedControl.selectedSegmentIndex = 1
          case .unspecified:
            segmentedControl.selectedSegmentIndex = 2
          @unknown default: //for cases which are there but we dont know about those like cusmot user themes on the phone loaded from net
            segmentedControl.selectedSegmentIndex = 2
        }
      }
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
