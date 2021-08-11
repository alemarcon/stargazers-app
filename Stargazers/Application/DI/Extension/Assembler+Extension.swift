//
//  Assembler.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation
import Swinject

extension Assembler {
    
    static var type: AssemblerType = .Default
    
    static let sharedAssembler: Assembler = {
        let container = Container()
        
        let assembler = Assembler([
            ViewControllerAssembly(),
            ViewModelAssembly(),
            RepositoryAssembly(),
            UseCaseAssembly(),
            NetworkAssembly()
        ], container: container)
        
        return assembler
    }()
}

enum AssemblerType {
    case Default
    case Test
}
