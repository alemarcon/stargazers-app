//
//  ViewModelAssembly.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(StargazerViewModel.self) { resolver in
            let viewModel = StargazerViewModelDefault()

            guard let useCase = resolver.resolve(StargazerUseCase.self) else {
                fatalError("Assembler was unable to resolve StargazerUseCaseDefault")
            }
            viewModel.useCase = useCase
            viewModel.useCase?.delegate = viewModel

            return viewModel
        }.inObjectScope(.transient)
        
    }

}
