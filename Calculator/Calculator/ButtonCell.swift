//
//  ButtonCell.swift
//  Calculator
//
//  Created by Usman Mazhar on 10/09/2023.
//
import Foundation
import UIKit

class ButtonCell: UICollectionViewCell {
    static let identifier = "ButtonCell"
    let button: UIButton = {
         let button = UIButton(type: .system)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
         button.setTitleColor(.white, for: .normal)
         return button
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        button.frame = contentView.bounds
        
        contentView.layer.cornerRadius = contentView.frame.size.width / 2
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let buttonTitles = [
    "C", "+/-", "%", "/",
    "7", "8", "9", "x",
    "4", "5", "6", "-",
    "1", "2", "3", "+",
    "0", ".", "=", ""
]

func buttonBackground(for title: String) -> UIColor {
    switch title {
    case "+", "-", "x", "/":
        return UIColor(red: 254/255.0, green: 148/255.0, blue: 0/255.0, alpha: 1.0) // Orange for operators
    case "C", "+/-", "%":
        return UIColor(red: 183/255.0, green: 183/255.0, blue: 186/255.0, alpha: 1.0) // Light gray for other buttons
    case ".", "0"..."9":
        return UIColor(red: 44/255.0, green: 44/255.0, blue: 46/255.0, alpha: 1.0) // Dark gray for numeric buttons
    default:
        return .clear
    }
}

extension UIColor {
    static var calculatorBackground: UIColor {
        return UIColor(red: 21/255.0, green: 22/255.0, blue: 25/255.0, alpha: 1.0) // Dark background color
    }
}

