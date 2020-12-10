//
//  TitleView.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import UIKit

class TitleView: UIView {
    var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.textAlignment = .center
        l.text = "알림" // test
        return l
    }()
    var closeButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(systemName: "xmark"), for: .normal)
        b.tintColor = .white
        return b
    }()
    var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            //
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            //
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            closeButton.widthAnchor.constraint(equalToConstant: 35),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 1),
            //
            segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            segmentedControl.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // test
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        self.addSubview(titleLabel)
        self.addSubview(closeButton)
        self.addSubview(segmentedControl)
    }
    
}
