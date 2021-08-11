//
//  RepositoryAssembly.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation
import Swinject

class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(StargazersRepository.self) { resolver in
            let repository = StargazersRepositoryDefault()

            guard let request = resolver.resolve(StargazersRequest.self) else {
                fatalError("Assembler was unable to resolve StargazersRequest")
            }
            repository.request = request

            return repository
        }.inObjectScope(.transient)

    }

}
