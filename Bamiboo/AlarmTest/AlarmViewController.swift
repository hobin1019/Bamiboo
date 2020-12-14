//
//  SwipeViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import UIKit

// MARK: AlarmViewController
class AlarmViewController: UIViewController {
    var vm: AlarmViewModel = AlarmViewModel()
    
    // MARK: Views
    lazy var titleView: TitleView = {
        let tv = TitleView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.titleLabel.text = "알림"
        tv.setTitles(titles: vm.allPageStates.map { $0.getTitle() })
        tv.closeButton.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        tv.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return tv
    }()
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.delegate = self
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
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.delegate = self
        view.backgroundColor = .black
        
        // titleView
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: TitleView.TITLE_VIEW_HEIGHT),
        ])
        // scrollView
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        // stackView
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(vm.allPageStates.count))
        ])
        
        vm.allPageStates.forEach { state in
            let sv = UIStackView() // 꽉차게 vc.view 바로 넣으려고 UIStackView 사용 (NSLayoutContraint 사용하기 번거로워서)
            stackView.addArrangedSubview(sv)
            sv.alignment = .fill
            sv.distribution = .fill
            let vc = state.getViewControllerType().init()
            sv.addArrangedSubview(vc.view)
            contentViews.append(vc) // 전역변수에 반영
        }
        
        // set Swipe Gesture (.left & .right)
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
        
        // 다른 ViewController의 navigationBar 상태와 상관없이 SwipeViewController 화면으로 진입하면 무조건 navigationBar Hidden 처리하기 위해 viewWillAppear 에 둠
        navigationController?.navigationBar.isHidden = true
        
        // 반드시 viewDidLoad 에서 addSubView 다 끝내고 처리해야하는 코드라 viewWillAppear 에 넣음
        view.bringSubviewToFront(titleView)
        
        // popViewController 를 통해 다시 보여졌을 때, API를 또 request 해야한다고 가정했을 때...
        vm.setNowPageState(0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // portrait <-> landscape 전환시 scrollView 의 offset 값을 회전 후의 scrollView width 값에 상대적으로 반영되기 위해 viewDidLayoutSubviews() 사용
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(vm.nowPageState), y: scrollView.contentOffset.y), animated: false)
    }
    
    
    // MARK: Event Handlers
    @objc private func closeBtnTapped() {
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


// MARK: AlarmViewControllerDelegate
extension AlarmViewController: AlarmViewDelegate {
    func disappearPage() {
        contentViews[vm.nowPageState].beginAppearanceTransition(false, animated: false)
    }
    
    func scrollPage() {
        let pageNum: Int = vm.nowPageState
        let offSetX = scrollView.frame.width * CGFloat(pageNum)
        let offSetY = scrollView.contentOffset.y
        
        if scrollView.contentOffset.x == offSetX { // scroll 안함 (초기화면의 경우)
            contentViews[vm.nowPageState].beginAppearanceTransition(true, animated: false)
        } else { // scroll 함 (페이지가 전환되는 경우)
            scrollView.setContentOffset(CGPoint(x: offSetX, y: offSetY), animated: true)
        }
        titleView.segmentedControl.selectedSegmentIndex = pageNum
    }
}


// MARK: UIScrollViewDelegate
extension AlarmViewController: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            /*
             가끔 공지사항 탭으로 갈 때, setContentOffset 애니메이션이 끊기는 경우가 있음!!
             -> 스크롤 처리 끝나는 시점마다 해당 페이지를 호출해 데이터를 가져오도록 함
             (단, setContentOffset 함수가 movePage 에서만 호출된다는 가정이 있어야 함;;;)
             */
            contentViews[vm.nowPageState].beginAppearanceTransition(true, animated: false)
        }
    }
}
