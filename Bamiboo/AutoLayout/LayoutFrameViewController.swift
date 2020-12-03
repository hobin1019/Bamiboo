//
//  LayoutProgrammaticallyViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/02.
//

import UIKit

/*
 [Understanding Auto Layout]
 외부요인 >> ex) 화면 회전에 따라 top에서 100만큼 떨어지도록 동작
 내부요인 >> ex) Slider 값에 따라 사이즈가 조정됨
 
 Frame으로 구현해보기
 */
class LayoutFrameMaskViewController: UIViewController {
    final let MAX_VIEW_SIZE: CGFloat = 300
    
    // UIViews
    var resizableView = UIView()
    var sliderView = UISlider()
    
    var frameSize: CGSize? {
        didSet {
            if let frameSize = frameSize {
                resizableView.frame.origin = CGPoint(x: (frameSize.width - resizableView.frame.size.width) / 2.0, y: 200)
                sliderView.frame.origin = CGPoint(x: (frameSize.width - sliderView.frame.size.width) / 2.0, y: frameSize.height - 100)
            }
        }
    }
    var resizableViewSize: CGSize {
        get { resizableView.frame.size }
        set {
            resizableView.frame.size = newValue
            if let frameSize = frameSize {
                resizableView.frame.origin = CGPoint(x: (frameSize.width - newValue.width) / 2.0, y: 200)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(resizableView)
        resizableView.backgroundColor = .orange
        resizableViewSize = CGSize(width: MAX_VIEW_SIZE, height: MAX_VIEW_SIZE)
        
        view.addSubview(sliderView)
        sliderView.frame.size = CGSize(width: 200, height: 20)
        sliderView.maximumValue = Float(MAX_VIEW_SIZE)
        sliderView.value = Float(MAX_VIEW_SIZE)
        sliderView.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        frameSize = view.frame.size
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        frameSize = size
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        resizableViewSize = CGSize(width: value, height: value)
    }
}
