//
//  AutoLayoutStackViewViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/03.
//

import UIKit

/*
 [Auto Layout Without Constraints]
 (문서) https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutWithoutConstraints.html#//apple_ref/doc/uid/TP40010853-CH8-SW1
 [UIStackView]
 (문서) https://developer.apple.com/documentation/uikit/uistackview
 
 
 # NSStackView properties
 1) axis            : vertical / horizontal 중 선택
 2) distribution    : axis 방향에 따른 layout 정의
 3) alignment       : axis 수직하는 방향에 따른 layout 정의
 4) spacing         : 내부 view 사이의 공간 정의
 
 
 # contentViews 의 size 지정하기
 (distribution 은 .fillEqually 와 .fillProportionally 를 제외하고는 contentViews 에 axis 방향의 contentSize를 명시해야함)
 (alignment 는 .fill 을 제외하고는 contentViews 에 axis 수직방향의 contentSize를 명시해야함)
 
 
 ?? 궁금한 점 ?? 😃
 spacing 값을 각각 다르게 줄 수는 없을까?
 >> setCustomSpacing 를 사용하면 가능 (단, iOS 11 부터)
 
 
 ?? 궁금한 점 ??
 isLayoutMarginsRelativeArrangement: Bool
 ⌈ true             >>  arranged views 를 layout margin 에 맞게 배치
 ⌊ false(default)   >>  arranged views 를 bounds 에 맞게 배치
 
 
 !!) StackView 를 사용하면, Constraints 없이 내부 View 들을 Auto Layout 할 수 있다!! 😁
 */
class AutoLayoutStackViewViewController: UIViewController {
    private struct Square {
        var size: CGFloat
        var backgroundColor: UIColor
    }
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .equalSpacing
        view.spacing = 10
        
        // StackView 의 layoutMargins property 를 사용하려면,
        // isLayoutMarginsRelativeArrangement 값을 true 로 해줘야함!!
        // 그렇지 않으면 bound에 맞게 세팅됨(??)
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 100, right: 40)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        
        [Square(size: 100, backgroundColor: .red),
         Square(size: 200, backgroundColor: .orange),
         Square(size: 150, backgroundColor: .yellow)]
            .forEach { square in
                let view = UIView()
                stackView.addArrangedSubview(view)
                view.backgroundColor = square.backgroundColor
                view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: square.size),
                    view.heightAnchor.constraint(equalToConstant: square.size),
                ])
            }
    }
}
