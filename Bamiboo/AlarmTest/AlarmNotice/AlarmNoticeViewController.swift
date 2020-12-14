//
//  AlarmNotice.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/10.
//

import UIKit

class AlarmNoticeViewController: UIViewController {
    let vm = AlarmNoticeViewModel()
    let reusableIdentifier = "cell"
    override var shouldAutomaticallyForwardAppearanceMethods: Bool { false }
    
    // MARK: Views
    lazy var contentCollectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .vertical
        l.headerReferenceSize = CGSize(width: view.bounds.width, height: TitleView.TITLE_VIEW_HEIGHT)
        l.estimatedItemSize = CGSize(width: view.bounds.width, height: 100) // UICollectionViewCell 고정 크기 (TODO : landscape 는???)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: l)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(AlarmNoticeCell.self, forCellWithReuseIdentifier: reusableIdentifier)
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
        print("공지 - viewWillAppear")
        vm.requestDataSource() // 탭 전환될 때마다 데이터 새로 가져오기
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("공지 - viewWillDisappear")
        // 탭 전환 직전에 데이터 지우기
    }
}

extension AlarmNoticeViewController: AlarmNoticeViewDelegate {
    func reloadContentsView() {
        contentCollectionView.reloadData()
    }
}

extension AlarmNoticeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! AlarmNoticeCell
        cell.setData(data: vm.dataSource[indexPath.row])
        let isHidden = !vm.isOpened.contains(indexPath.row)
        cell.setContentsView(isHidden: isHidden)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // let offsetY = collectionView.contentOffset.y
        vm.addOpenView(indexPath.row)
        collectionView.reloadItems(at: [indexPath])
        
        /*
        collectionView.performBatchUpdates({
                        collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x, y: offsetY), animated: false) // test
        }, completion: { _ in
//            collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x, y: offsetY), animated: false) // test
            collectionView.scrollToItem(at: IndexPath(row: indexPath.row, section: indexPath.section), at: .centeredVertically, animated: false)
        })
         */
    }
}

extension AlarmNoticeViewController: UICollectionViewDelegate {
}
