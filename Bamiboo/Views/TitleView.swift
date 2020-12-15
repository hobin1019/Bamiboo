//
//  TitleView.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import UIKit

class TitleView: UIView {
    static let TITLE_VIEW_HEIGHT: CGFloat = 100
    
    // MARK: Views
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    var segmentedControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: [])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.selectedSegmentTintColor = .red
        segmentControl.backgroundColor = .lightGray
        
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        return segmentControl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // TitleView 를 사용하는 ViewController 가 Layout 처리할 때, 처리되도록
        NSLayoutConstraint.activate([
            // titleLabel
            titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            // closeButton
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            closeButton.widthAnchor.constraint(equalToConstant: 35),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 1),
            // segmentedControl
            segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            segmentedControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        self.addSubview(titleLabel)
        self.addSubview(closeButton)
        self.addSubview(segmentedControl)
    }
    
    
    // MARK: Public Functions
    func setTitles(titles: [String]) {
        titles.indices.forEach {
            segmentedControl.insertSegment(withTitle: titles[$0], at: $0, animated: false)
        }
    }
}
