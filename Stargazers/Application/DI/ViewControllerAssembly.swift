//
//  ViewControllerAssembly.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation
import Swinject

class ViewControllerAssembly: Assembly {
    
    enum ViewControllerIds: String {
        case splash_vc
        case stargazer_vc
    }
    
    func assemble(container: Container) {
        
        // Splash view controller initialization
        container.register(SplashViewController.self) { resolver in
            guard let controller: SplashViewController = UIStoryboard(.Splash).instantiateViewController(withIdentifier: ViewControllerIds.splash_vc.rawValue) as? SplashViewController else {
                fatalError("Assembler was unable to resolve SplashViewController")
            }
            
            return controller
        }.inObjectScope(.transient)
        
        // StargazerViewController initialization
        container.register(StargazerViewController.self) { resolver in
            guard let controller: StargazerViewController = UIStoryboard(.Main).instantiateViewController(withIdentifier: ViewControllerIds.stargazer_vc.rawValue) as? StargazerViewController else {
                fatalError("Assembler was unable to resolve StargazerViewController")
            }
            
            guard let viewModel = resolver.resolve(StargazerViewModel.self) else {
                fatalError("Assembler was unable to resolve StargazerViewModel")
            }
            controller.viewModel = viewModel
            
            return controller
        }.inObjectScope(.transient)
        
    }
    
}
