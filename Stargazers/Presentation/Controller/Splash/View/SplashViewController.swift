//
//  SplashViewController.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import UIKit
import Swinject

class SplashViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Only for show splash view controller
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.runMainViewController()
        }
    }
    
    private func runMainViewController() {
        if let mainViewController = Assembler.sharedAssembler.resolver.resolve(StargazerViewController.self) {
            let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
            nvc.setNavigationBarHidden(true, animated: false)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = nvc
        }
    }
}
