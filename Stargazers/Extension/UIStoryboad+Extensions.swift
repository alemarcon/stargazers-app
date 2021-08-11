//
//  UIStoryboad+Extensions.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import UIKit

extension UIStoryboard {

    enum Storyboard: String {
        case Splash
        case Main
    }
    
    convenience init(_ storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
}
