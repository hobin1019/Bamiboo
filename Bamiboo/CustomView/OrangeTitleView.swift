//
//  OrangeTitleView.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/07.
//

import UIKit

@IBDesignable
class OrangeTitleView: UIView {
    var titleLabel: UILabel!
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var title: String {
        get { return titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    @IBInspectable var backColor: UIColor {
        get { return self.backgroundColor ?? .white }
        set { self.backgroundColor = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "hi"
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        print(self.bounds)
        self.bounds.origin = CGPoint(x: 100, y: 50)
        self.clipsToBounds = false // (default : false)
        print(self.bounds)
    }
}
