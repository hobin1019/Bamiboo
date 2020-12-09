//
//  SwipeViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import UIKit

// MARK: SwipeViewController
class SwipeViewController: UIViewController {
    var vm: SwipeViewControllerModel = SwipeViewControllerModel()
    
    
    // MARK: Views
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isScrollEnabled = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 0
        return sv
    }()
    var contentViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.delegate = self
        
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 3)
        ])
        
        contentViews.removeAll() // 이건 그냥... 습관적으로
        vm.getAllPageStates().forEach { state in
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(view)
            contentViews.append(view)
            
            switch (state) {
            case .myNews:
                view.backgroundColor = .red
            case .waitForFree:
                view.backgroundColor = .orange
            case .notice:
                view.backgroundColor = .yellow
            }
        }
        
        // set Swipe Gesture
        let swipeRightGR = UISwipeGestureRecognizer()
        swipeRightGR.direction = .right
        swipeRightGR.addTarget(self, action: #selector(viewSwiped(_:)))
        view.addGestureRecognizer(swipeRightGR)
        let swipeLeftGR = UISwipeGestureRecognizer()
        swipeLeftGR.direction = .left
        swipeLeftGR.addTarget(self, action: #selector(viewSwiped(_:)))
        view.addGestureRecognizer(swipeLeftGR)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // popViewController 를 통해 다시 보여졌을 때, API를 또 request 해야한다고 가정했을 때...
        movePage()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // portrait <-> landscape 전환시 scrollView 의 offset 값을 회전 후의 scrollView width 값에 상대적으로 반영되기 위해 viewDidLayoutSubviews() 사용
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(vm.getNowPageState()), y: scrollView.contentOffset.y), animated: false)
    }
    
    
    // MARK: Event Handlers
    @objc private func viewSwiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            vm.setNowPageState(.next)
        } else if gesture.direction == .right {
            vm.setNowPageState(.prev)
        }
    }
    
}


// MARK: SwipeViewControllerDelegate
extension SwipeViewController: SwipeViewControllerDelegate {
    
    func movePage() {
        let pageNum: Int = vm.getNowPageState()
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(vm.getNowPageState()), y: scrollView.contentOffset.y), animated: true)
        
        let pageState = vm.getAllPageStates()[pageNum]
        switch (pageState) {
        case .myNews:
            print("request myNews API")
        case .waitForFree:
            print("request waitForFree API")
        case .notice:
            print("request notice API")
        }
    }
    
}
