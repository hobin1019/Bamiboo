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
    var titleView: TitleView!
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
    var contentViews: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.delegate = self
        view.backgroundColor = .black
        
        // titleView
        titleView = TitleView()
        titleView.setTitles(titles: vm.getAllPageStates().map { $0.getTitle() })
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            // titleView
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: TitleView.TITLE_VIEW_HEIGHT),
        ])
        // ------ set Target
        titleView.closeButton.addTarget(self, action: #selector(closeBtnClicked), for: .touchUpInside)
        titleView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
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
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(vm.getAllPageStates().count))
        ])
        
        contentViews.removeAll() // 이건 그냥... 습관적으로
        vm.getAllPageStates().forEach { state in
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.alignment = .fill
            sv.distribution = .fill
            stackView.addArrangedSubview(sv)
            let vc = state.getViewControllerType().init()
            self.addChild(vc)
//            vc.didMove(toParent: self)
            sv.addArrangedSubview(vc.view)
            contentViews.append(vc)
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
        
        navigationController?.navigationBar.isHidden = true
        view.bringSubviewToFront(titleView)
        
        // popViewController 를 통해 다시 보여졌을 때, API를 또 request 해야한다고 가정했을 때...
        movePage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // portrait <-> landscape 전환시 scrollView 의 offset 값을 회전 후의 scrollView width 값에 상대적으로 반영되기 위해 viewDidLayoutSubviews() 사용
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(vm.getNowPageState()), y: scrollView.contentOffset.y), animated: false)
    }
    
    
    // MARK: Event Handlers
    @objc private func closeBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func segmentedControlValueChanged(_ segment: UISegmentedControl) {
        vm.setNowPageState(segment.selectedSegmentIndex)
    }
    
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
        let offSetX = scrollView.frame.width * CGFloat(pageNum)
        let offSetY = scrollView.contentOffset.y
        
        scrollView.setContentOffset(CGPoint(x: offSetX, y: offSetY), animated: true)
        contentViews[pageNum].didMove(toParent: self)
        
        titleView.segmentedControl.selectedSegmentIndex = pageNum
    }
    
}
