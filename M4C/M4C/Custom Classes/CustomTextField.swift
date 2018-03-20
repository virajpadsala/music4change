//
//  CustomTextField.swift
//  GoTeam
//
//  Created by Viraj Padsala on 6/5/17.
//  Copyright © 2017 Viraj Padsala. All rights reserved.
//

import UIKit

private var maxLengthDictionary = [UITextField:Int]()

class CustomTextField: UITextField {
    
    var topBorder: UIView?
    var bottomBorder: UIView?
    var leftBorder: UIView?
    var rightBorder: UIView?
    var leftimageview : UIImageView?
    var rightimageview : UIImageView?
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var placeHolderColor : UIColor = UIColor.lightGray {
        didSet {
            setValue(placeHolderColor, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    @IBInspectable var rightImage : UIImage? {
        didSet {
            if rightImage != nil {
                let width = rightviewWidth < rightImage!.size.width + 10 ? rightviewWidth :  rightImage!.size.width + 10
                rightViewMode = UITextFieldViewMode.always
                rightimageview = UIImageView()
                rightimageview!.frame = CGRect(x: self.frame.size.width - width, y: self.frame.origin.y+2, width: width, height: CGFloat(self.frame.size.height-4))
                rightimageview!.image = rightImage
                rightView = rightimageview
                self.rightViewMode = .always
                rightimageview!.contentMode = .center
            }
        }
    }
    @IBInspectable var rightviewWidth : CGFloat = 0 {
        didSet{
            if rightimageview != nil{
                let width = rightviewWidth < rightImage!.size.width + 10 ? rightviewWidth :  rightImage!.size.width + 10
                rightimageview!.frame = CGRect(x: self.frame.origin.x+5, y: self.frame.origin.y+2, width: width, height: CGFloat(self.frame.size.height-4))
            }
        }
    }
    @IBInspectable var leftImage : UIImage? {
        didSet {
            if leftImage != nil {
                let width = leftviewWidth < leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftViewMode = UITextFieldViewMode.always
                leftimageview = UIImageView();
                leftimageview!.frame = CGRect(x: self.frame.origin.x+5, y: self.frame.origin.y+2, width: width, height: CGFloat(self.frame.size.height-4))
                leftimageview!.image = leftImage;
                leftView = leftimageview;
                self.leftViewMode = .always
                leftimageview!.contentMode = .center
            }
        }
    }
    @IBInspectable var leftviewWidth : CGFloat = 0 {
        didSet{
            if leftimageview != nil{
                let width = leftviewWidth < leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftimageview!.frame = CGRect(x: self.frame.origin.x+5, y: self.frame.origin.y+2, width: width, height: CGFloat(self.frame.size.height-4))
            }
        }
    }
    @IBInspectable var bottomLineWidth : CGFloat = 1 {
        didSet{
            let border: CALayer = CALayer()
            border.borderColor = UIColor.darkGray.cgColor
            self.frame = CGRect(x: 0, y: self.frame.size.height - bottomLineWidth, width: self.frame.size.width, height: self.frame.size.height)
            border.borderWidth = borderWidth
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var bottomLineColor : UIColor = UIColor.lightGray {
        didSet {
            let border: CALayer = CALayer()
            border.borderColor = bottomLineColor.cgColor
        }
    }
    
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    @IBInspectable var topBorderColor : UIColor = UIColor.clear
    @IBInspectable var topBorderHeight : CGFloat = 0 {
        didSet{
            if topBorder == nil{
                topBorder = UIView()
                topBorder?.backgroundColor=topBorderColor;
                topBorder?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: topBorderHeight)
                addSubview(topBorder!)
            }
        }
    }
    
    @IBInspectable var bottomBorderColor : UIColor = UIColor.clear
    @IBInspectable var bottomBorderHeight : CGFloat = 0 {
        didSet{
            if bottomBorder == nil{
                self.layoutSubviews()
                self.layoutIfNeeded()
                
                bottomBorder = UIView()
                bottomBorder?.backgroundColor=bottomBorderColor;
                bottomBorder?.frame = CGRect(x: 0, y: self.frame.size.height - bottomBorderHeight, width: self.frame.size.width, height: bottomBorderHeight)
                addSubview(bottomBorder!)
            }
        }
    }
    
    @IBInspectable var leftBorderColor : UIColor = UIColor.clear
    @IBInspectable var leftBorderHeight : CGFloat = 0 {
        didSet{
            if leftBorder == nil{
                leftBorder = UIView()
                leftBorder?.backgroundColor=leftBorderColor;
                leftBorder?.frame = CGRect(x: 0, y: 0, width: leftBorderHeight, height: self.frame.size.height)
                addSubview(leftBorder!)
            }
        }
    }
    @IBInspectable var rightBorderColor : UIColor = UIColor.clear
    @IBInspectable var rightBorderHeight : CGFloat = 0 {
        didSet{
            if rightBorder == nil{
                rightBorder = UIView()
                rightBorder?.backgroundColor=topBorderColor;
                rightBorder?.frame = CGRect(x: self.frame.size.width - rightBorderHeight, y: 0, width: rightBorderHeight, height: self.frame.size.height)
                addSubview(rightBorder!)
            }
        }
    }
    @IBInspectable var maxLength: Int {
        get {
            if let length = maxLengthDictionary[self] {
                return length
            } else {
                return Int.max
            }
        }
        set {
            maxLengthDictionary[self] = newValue
            addTarget(self, action: Selector(("checkMaxLength:")), for: UIControlEvents.editingChanged)
        }
    }
    
    func checkMaxLength(sender: UITextField) {
        let newText = sender.text
        if (newText?.count)! < maxLength {
            let cursorPosition = selectedTextRange
            text = (newText! as NSString).substring(with: NSRange(location: 0, length: maxLength))
            selectedTextRange = cursorPosition
        }
    }
}
