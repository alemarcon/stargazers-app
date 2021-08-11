//
//  NetworkAssembly.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation
import Swinject

class NetworkAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(StargazersRequest.self) { resolver in
            
            if( Assembler.type == .Test ) {
                let request = StargazerDataRequestTest()
                return request
            } else {
                return StargazersRequestDefault()
            }
            
        }.inObjectScope(.transient)
        
    }
    
}
