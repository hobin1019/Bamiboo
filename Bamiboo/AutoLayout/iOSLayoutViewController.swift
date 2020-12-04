//
//  iOSLayoutViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/04.
//

import UIKit

class iOSLayoutViewController: UIViewController {
    lazy var orangeView: UIView = {
        let v = UIView()
        v.backgroundColor = .orange
        v.frame.size = CGSize(width: 100, height: 100)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        view.addSubview(orangeView)
        
        /*
         ?? 궁금한 점 ??
         개념은 Padding 에 더 가까운거 같은데, 왜 LayoutMargins 라는 이름을 쓰는가?
         */
        // layoutMargins 는 UIEdgeInsets 이고, layoutMarginGuide 는 NSLayoutConstraint 다!!!
        // layoutMarginsGuide 의 default margin 값은 각각 8 point!!
        view.layoutMargins = UIEdgeInsets(top: 30, left: 100, bottom: 0, right: 0) // TextView 구성할 때, padding 주려고 구현하기도 함!!
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orangeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),           // self.topLayoutGuide 는 deprecated 됨
            orangeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),     // self.bottomLayoutGuide 는 deprecated 됨
            orangeView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),    // default (8 points)
            orangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        print(orangeView.layoutMargins.left)    // (default : 8)
        print(view.layoutMargins.left)          // 100
        print(orangeView.frame.origin)          // (0.0, 0.0) 😲 호오~
        print(orangeView.bounds.origin)         // (0.0, 0.0) 😲 호오(?) ->>> frame, bounds 차이 알아보기!!
        
    }

}
