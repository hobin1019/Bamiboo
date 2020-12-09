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
    
    
    // MARK: init
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
    }
    
    
    // MARK: draw(_:)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        print(self.bounds)
//        self.bounds.origin = CGPoint(x: 100, y: 50)
        self.clipsToBounds = false // (default : false)
        print(self.bounds)
        
        
        titleLabel.frame = self.bounds
        titleLabel.textColor = .red
        titleLabel.textAlignment = .center
        
        
        let layer = CALayer()
        layer.frame = self.bounds

        layer.contents = [UIImage(named: "background_ponyo")?.cgImage]
        self.layer.addSublayer(layer)
        layer.setNeedsLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched in OrangeTitleView")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print(point)
        return super.hitTest(point, with: event)
    }
}
