//
//  AlarmMyNewsController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/10.
//

import UIKit

class AlarmMyNewsViewController: UIViewController {
    let vm = AlarmMyNewsViewModel()
    let reusableIdentifier = "cell"
    
    // MARK: Views
    lazy var contentCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(114))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(AlarmMyNewsCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        vm.delegate = self
        view.backgroundColor = .black
        
        
        // ------ set Layout
        view.addSubview(contentCollectionView)
        NSLayoutConstraint.activate([
            contentCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        vm.requestDataSource()
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
        return vm.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as? AlarmMyNewsCell else {
            return UICollectionViewCell()
        }
        let data = vm.dataSource[indexPath.row]
        cell.setData(data: data)
        return cell;
    }
    
}
