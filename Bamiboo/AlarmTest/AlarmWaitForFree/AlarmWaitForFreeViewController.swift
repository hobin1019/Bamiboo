//
//  AlarmWaitForFreeViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/10.
//

import UIKit

class AlarmWaitForFreeViewController: UIViewController {
    private let vm = AlarmWaitForFreeViewModel()
    private let reusableIdentifier = "cell"
    override var shouldAutomaticallyForwardAppearanceMethods: Bool { false }
    
    // MARK: Views
    lazy var contentCollectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .vertical
        l.headerReferenceSize = CGSize(width: view.bounds.width, height: TitleView.TITLE_VIEW_HEIGHT)
        l.itemSize = CGSize(width: view.bounds.width, height: 100) // UICollectionViewCell 고정 크기 (TODO : landscape 는???)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: l)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(AlarmWaitForFreeCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        vm.delegate = self
        view.backgroundColor = .black
        
        view.addSubview(contentCollectionView)
        NSLayoutConstraint.activate([
            contentCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("기다무 - viewWillAppear")
        vm.requestDataSource() // 탭 전환될 때마다 데이터 새로 가져오기
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("기다무 - viewWillDisappear")
        // 탭 전환 직전에 데이터 지우기
    }
}


// MARK: AlarmViewDelegate
extension AlarmWaitForFreeViewController: AlarmWaitForFreeViewDelegate {
    func reloadCollectionView() {
        contentCollectionView.reloadData()
    }
}


// MARK: UICollectionViewDelegate
extension AlarmWaitForFreeViewController: UICollectionViewDelegate {
    
}


// MARK: UICollectionViewDataSource
extension AlarmWaitForFreeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! AlarmWaitForFreeCell
        cell.setData(data: vm.dataSource[indexPath.row])
        return cell
    }
    
}
