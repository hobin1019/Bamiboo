//
//  AlarmMyNewsController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/10.
//

import UIKit

class AlarmMyNewsViewController: UIViewController {
    private let viewModel = AlarmMyNewsViewModel()
    private let reusableIdentifier = "cell"
    override var shouldAutomaticallyForwardAppearanceMethods: Bool { false }
    
    // MARK: Views
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: TitleView.TITLE_VIEW_HEIGHT)
        layout.itemSize = CGSize(width: view.bounds.width, height: 140) // UICollectionViewCell 고정 크기 (TODO : landscape 는???)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AlarmMyNewsCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
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
        print("내소식 - viewWillAppear")
        viewModel.requestDataSource() // 탭 전환될 때마다 데이터 새로 가져오기
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("내소식 - viewWillDisappear")
        // 탭 전환 직전에 데이터 지우기
    }
}


// MARK: AlarmViewDelegate
extension AlarmMyNewsViewController: AlarmMyNewsViewDelegate {
    func reloadCollectionView() {
        contentCollectionView.reloadData()
    }
}


// MARK: UICollectionViewDelegate
extension AlarmMyNewsViewController: UICollectionViewDelegate {
    
}


// MARK: UICollectionViewDataSource
extension AlarmMyNewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! AlarmMyNewsCell
        cell.setData(data: viewModel.dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.readItem(indexPath.row)
        collectionView.reloadItems(at: [indexPath])
    }
}
