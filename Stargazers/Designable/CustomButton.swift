//
//  CustomButton.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    private var cornersSet: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
        updateColor()
        updateBorder()
    }
    
    /// <#Description#>
    @IBInspectable var shadow: Bool = false {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable var roundedRadius: CGFloat = 0.0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    /// <#Description#>
    func updateCornerRadius() {
        
        if roundedRadius > 0.0 {
            layer.cornerRadius = roundedRadius > 0.0 ? roundedRadius : (frame.size.height / 2)
        } else {
            layer.cornerRadius = 0
        }
    }
    
    /// <#Description#>
    func updateShadow() {
        if( shadow ) {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    
    /// Add a border line to the botton
    @IBInspectable var border: CGFloat = 1 {
        didSet {
            updateBorder()
        }
    }

    /// Change border botton color
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            updateColor()
        }
    }
    
    /// Update border botton color
    private func updateColor() {
        layer.borderColor = borderColor.cgColor
    }

    /// Update botton border width
    private func updateBorder() {
        layer.borderWidth = border
    }
    
}
