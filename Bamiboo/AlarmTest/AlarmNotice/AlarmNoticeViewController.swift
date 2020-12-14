//
//  AlarmNotice.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/10.
//

import UIKit

class AlarmNoticeViewController: UIViewController {
    let viewModel = AlarmNoticeViewModel()
    let reusableIdentifier = "cell"
    override var shouldAutomaticallyForwardAppearanceMethods: Bool { false }
    
    // MARK: Views
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: TitleView.TITLE_VIEW_HEIGHT)
        layout.estimatedItemSize = CGSize(width: view.bounds.width, height: 100) // UICollectionViewCell 고정 크기 (TODO : landscape 는???)
        
        let collcetionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collcetionView.translatesAutoresizingMaskIntoConstraints = false
        collcetionView.register(AlarmNoticeCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        collcetionView.delegate = self
        collcetionView.dataSource = self
        return collcetionView
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
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
        viewModel.requestDataSource() // 탭 전환될 때마다 데이터 새로 가져오기
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("공지 - viewWillDisappear")
        // 탭 전환 직전에 데이터 지우기
    }
}

extension AlarmNoticeViewController: AlarmNoticeViewDelegate {
    func collectionViewWillReload() {
        contentCollectionView.reloadData()
    }
}

extension AlarmNoticeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! AlarmNoticeCell
        cell.setData(data: viewModel.dataSource[indexPath.row])
        let isHidden = !viewModel.isOpened.contains(indexPath.row)
        cell.setContentsView(isHidden: isHidden)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // let offsetY = collectionView.contentOffset.y
        viewModel.addOpenView(indexPath.row)
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
