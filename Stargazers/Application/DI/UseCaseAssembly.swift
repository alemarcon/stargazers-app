//
//  UseCaseAssembly.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation
import Swinject

class UseCaseAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(StargazerUseCase.self) { resolver in
            let useCase = StargazerUseCaseDefault()
            guard let repository = resolver.resolve(StargazersRepository.self) else {
                fatalError("Assembler was unable to resolve StargazersRepository")
            }
            useCase.repository = repository
            return useCase
        }.inObjectScope(.transient)
        
    }

}
