//
//  UIView+.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/14.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import UIKit

extension UIView {
    // borderColor
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor.map{ UIColor(cgColor: $0) } }
        set (color){ layer.borderColor = color?.cgColor }
    }
    
    // borderwidth
    @IBInspectable var borderwidth: CGFloat {
        get { return layer.borderWidth }
        set(borderWidth) { layer.borderWidth = borderWidth }
    }
    
    // cornerRadius
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set(cornerRadius) { layer.cornerRadius = cornerRadius}
    }
    
    // masksToBounds
    @IBInspectable var masksToBounds: Bool {
        get { return layer.masksToBounds }
        set (masksToBounds) { layer.masksToBounds = masksToBounds}
    }
    
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set(shadowOpacity) { layer.shadowOpacity = shadowOpacity }
    }
    
    @IBInspectable var shadowOffset : CGSize{
        get { return layer.shadowOffset}
        set(shadowOffset) { layer.shadowOffset = shadowOffset}
    }
    
    @IBInspectable var shadowRadius : CGFloat{
        get{ return layer.shadowRadius }
        set(shadowRadius) { layer.shadowRadius = shadowRadius }
    }
    
    
//    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadius: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
    
}


extension UILabel {
    func setSizeFont (sizeFont: CGFloat) {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)!
        self.sizeToFit()
    }
}

extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            if self.text.count > 0{
            placeholderLabel.isHidden = true
            }
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        if self.text.count > 0{
            placeholderLabel.isHidden = true
        }
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}

