//
//  LayoutProgrammaticallyViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/02.
//

import UIKit

/*
 [Understanding Auto Layout]
 1. Frame-Based Layout 으로 구현해보기
 
 외부요인 >> ex) 화면 회전 / slider 값에 따라 화면 중앙에 위치하도록
 내부요인 >> ex) slider 값에 따라 사이즈가 조정되도록
 
 ----------------------------------------------------
 
 !!) view / superview 각각의 사이즈 변화에 따라 계산된 값으로 frame 을 재설정해주어야한다!!
     => frame 계산하는게 귀찮고 복잡할 수 있음, life cycle 및 기능동작에 맡게 언제 frame 을 재설정해주어야 하는지도 고려해야함 🤮
 */
class LayoutFrameMaskViewController: UIViewController {
    final let MAX_VIEW_SIZE: CGFloat = 300
    
    // UIViews
    lazy var resizableView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.frame.size = CGSize(width: 200, height: 20)
        slider.maximumValue = Float(MAX_VIEW_SIZE)
        slider.value = Float(MAX_VIEW_SIZE)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    var frameSize: CGSize? {
        didSet {
            if let frameSize = frameSize {
                resizableView.center = CGPoint(x: frameSize.width / 2.0, y: frameSize.height / 2.0)
                sliderView.frame.origin = CGPoint(x: (frameSize.width - sliderView.frame.size.width) / 2.0, y: frameSize.height - 100)
            }
        }
    }
    var resizableViewSize: CGSize {
        get { resizableView.frame.size }
        set {
            resizableView.frame.size = newValue
            if let frameSize = frameSize {
                resizableView.center = CGPoint(x: frameSize.width / 2.0, y: frameSize.height / 2.0)
            }
        }
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(resizableView)
        view.addSubview(sliderView)
        
        resizableViewSize = CGSize(width: MAX_VIEW_SIZE, height: MAX_VIEW_SIZE)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        frameSize = view.frame.size
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        frameSize = size
    }
    
    
    // MARK: Action Handler
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        resizableViewSize = CGSize(width: value, height: value)
    }
}
