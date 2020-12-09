//
//  AlarmViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/08.
//

import UIKit


class AlarmViewController: ViewController {
    let vm = AlarmViewModel()
    let reusableIdentifier = "cell"
    
    // MARK: Views
    var titleView: TitleView!
    
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
        navigationController?.navigationBar.isHidden = true

        vm.delegate = self
        view.backgroundColor = .black
        
        
        // ------ set Layout
        titleView = TitleView()
        view.addSubview(titleView)
        view.addSubview(contentCollectionView)
        
        NSLayoutConstraint.activate([
            // titleView
            titleView.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: safeAreaLayout.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 100),
            // contentCollectionView
            contentCollectionView.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor),
            contentCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayout.bottomAnchor),
            contentCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor),
            contentCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayout.trailingAnchor),
        ])
        
        view.bringSubviewToFront(titleView)
        
        // ------ set Target
        titleView.closeButton.addTarget(self, action: #selector(closeBtnClicked), for: .touchUpInside)
        titleView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vm.requestDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Event Handler
    @objc private func closeBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func segmentedControlValueChanged(_ segment: UISegmentedControl) {
        
    }
}


// MARK: AlarmViewDelegate
extension AlarmViewController: AlarmViewDelegate {
    func reloadCollectionView() {
        contentCollectionView.reloadData()
    }
}


// MARK: UICollectionViewDelegate
extension AlarmViewController: UICollectionViewDelegate {
    
}


// MARK: UICollectionViewDataSource
extension AlarmViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.dataSource[vm.tapState.rawValue].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as? AlarmMyNewsCell else {
            return UICollectionViewCell()
        }
        let data = vm.dataSource[vm.tapState.rawValue][indexPath.row]
        cell.setData(data: data)
        return cell;
    }
    
}
