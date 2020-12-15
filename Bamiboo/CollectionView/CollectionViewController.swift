//
//  CollectionViewController.swift
//  Bamiboo
//
//  Created by 한호빈 on 2020/12/10.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var dataSource: [String] = ["first item\nhihi", "second item hello", "3rd ;laksjdf;laskdjf", "4!! hihihihihih\nllllasdkfjhslkdjhcxkmjvs\nhello"]
    var isOpenedArr: [Bool] = [false, false, false, false]
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .vertical
        l.headerReferenceSize = CGSize(width: 100, height: 150)
        l.itemSize = CGSize(width: view.bounds.width, height: 100)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: l)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
    }


    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.title = dataSource[indexPath.row]
        return cell
    }

    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isOpenedArr[indexPath.row] = !isOpenedArr[indexPath.row]
        
        let open = isOpenedArr[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            let maxSize = CGSize(width: collectionView.frame.width, height: CGFloat.infinity)
            let expectedSize = NSString(string: self.dataSource[indexPath.row]).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: CollectionViewCell.titleAttribute, context: nil)
            let cellHeightTo: CGFloat = open ? 200 : expectedSize.height
            
            collectionView.performBatchUpdates({
                collectionView.collectionViewLayout.invalidateLayout()
            })
            
            UIView.animate(withDuration: 1, animations: {
                cell.frame.size = CGSize(width: collectionView.frame.width, height: cellHeightTo)
            })
        }
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = CGSize(width: collectionView.frame.width, height: CGFloat.infinity)
        let expectedSize = NSString(string: dataSource[indexPath.row]).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: CollectionViewCell.titleAttribute, context: nil)
        let cellHeightTo: CGFloat = isOpenedArr[indexPath.row] ? 200 : expectedSize.height
        
        return CGSize(width: collectionView.frame.width, height: cellHeightTo)
    }
}

class CollectionViewCell: UICollectionViewCell {
    static let titleAttribute: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 20)
    ]
    var title: String {
        get { titleLabel.text ?? ""}
        set {
            titleLabel.attributedText = NSAttributedString(string: newValue, attributes: CollectionViewCell.titleAttribute)
            titleLabel.sizeToFit()
        }
    }
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .yellow
        self.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .red
        self.addSubview(titleLabel)
    }
    
}
