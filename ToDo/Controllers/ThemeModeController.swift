//
//  ThemeModeController.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-07-25.
//

import UIKit

/// This allow the user to change the device theme to be changed light/ dark/ system

class ThemeModeController: UIViewController {
  @IBOutlet weak var themeHeadLabel: UILabel!
  @IBOutlet weak var appTheme: UILabel!
  @IBOutlet weak var settingsModal: UIView!
  @IBOutlet var settingsView: UIView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
      
    }

  private func setupview() {
    themeHeadLabel.font = UIFont.style(.category)
    appTheme.font = UIFont.style(.caption)
    settingsModal.backgroundColor = .secondarySystemBackground
    settingsModal.transform = CGAffineTransform(scaleX: 0, y: 0)
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
        @unknown default: //for cases which are there but we dont know about those like custom user themes on the phone loaded from net
          segmentedControl.selectedSegmentIndex = 2
      }
    }
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //reusing animation for UIView mentioned in Design/Animations
    settingsModal.scaleUpAnimation()
  }
    
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    settingsModal.layer.cornerRadius = 10
  }
  
  @IBAction func closeSettingstapped(_ sender: Any) {
    dismiss(animated: true)
  }
  
  @IBAction func themeModeTapped(_ sender: UISegmentedControl) {
    /*
    - uiapplication -> including:
    - windowscenes ->
    - windows ->
    - key window ->
    - overrideUserINterfaceStyle (thats where we are changing the theme in)
     */
    let window = UIApplication.shared.connectedScenes.flatMap {($0 as? UIWindowScene)?.windows ?? [] }.first {$0.isKeyWindow} //looking for scenes in the app with flatMap (returns array) while compactMap(returns array of array)
    if sender.selectedSegmentIndex == 0 {
      window?.overrideUserInterfaceStyle = .light //UIUserInterfaceStyle.light
      UserDefaults.standard.set(0, forKey: "themeMode")
    }
    else if sender.selectedSegmentIndex == 1 {
      window?.overrideUserInterfaceStyle = .dark
      UserDefaults.standard.set(1, forKey: "themeMode")
    }
    else {
      window?.overrideUserInterfaceStyle = .unspecified
      UserDefaults.standard.set(2, forKey: "themeMode")
    }
  }
  ///UserDefaults then passed and extracted to sceneDelegate with Int properties

}


