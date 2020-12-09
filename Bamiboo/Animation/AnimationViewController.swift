//
//  AnimationViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/07.
//

import UIKit

class AnimationViewController: UIViewController {
    private var animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn)
    
    lazy var orangeView: UIView = {
        let v = UIView()
        v.backgroundColor = .orange
        view.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v.widthAnchor.constraint(equalToConstant: 100),
            v.heightAnchor.constraint(equalToConstant: 100),
            v.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(orangeView)
        
        animator.addAnimations {
            self.orangeView.backgroundColor = .blue
        }
        animator.addAnimations {
            self.view.bounds.origin = CGPoint(x: 50, y: 50)
        }
        animator.startAnimation()
    }
    
    
}
