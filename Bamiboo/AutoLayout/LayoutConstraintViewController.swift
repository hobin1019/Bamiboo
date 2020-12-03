//
//  LayoutConstraintViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/03.
//

import UIKit

/*
 [Understanding Auto Layout]
 1. Constraint Layout 으로 구현해보기
 
 외부요인 >> ex) 화면 회전 / slider 값에 따라 화면 중앙에 위치하도록
 내부요인 >> ex) slider 값에 따라 사이즈가 조정되도록
 
 ----------------------------------------------------
 
 !!) superview / view의 사이즈변화에 layout 자체가 유기적으로 반응함
     => frame-based layout 보다 적용하기 편리함 😁
 */
class LayoutConstraintViewController: UIViewController {
    final let MAX_VIEW_SIZE: CGFloat = 300
    
    // UIViews
    var orangeView = UIView()
    var sliderView = UISlider()
    
    // Constraints
    var orangeViewSize: CGSize {
        get { orangeView.frame.size }
        set {
            orangeView.constraints
                .filter {$0.identifier == "orangeViewWidth" || $0.identifier == "orangeViewHeight"}
                .forEach { orangeView.removeConstraint($0) }
            
            let widthConstraint = orangeView.widthAnchor.constraint(equalToConstant: newValue.width)
            widthConstraint.identifier = "orangeViewWidth"
            let heightConstraint = orangeView.heightAnchor.constraint(equalToConstant: newValue.height)
            heightConstraint.identifier = "orangeViewHeight"
            NSLayoutConstraint.activate([
                widthConstraint,
                heightConstraint,
            ])
        }
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(orangeView)
        orangeView.backgroundColor = .orange
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeViewSize = CGSize(width: MAX_VIEW_SIZE, height: MAX_VIEW_SIZE)
        NSLayoutConstraint.activate([
            orangeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orangeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.addSubview(sliderView)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderView.widthAnchor.constraint(equalToConstant: 200),
            sliderView.heightAnchor.constraint(equalToConstant: 20),
            sliderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sliderView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
        sliderView.maximumValue = Float(MAX_VIEW_SIZE)
        sliderView.value = Float(MAX_VIEW_SIZE)
        sliderView.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    
    // MARK: Action Handlers
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        orangeViewSize = CGSize(width: value, height: value)
    }
}
