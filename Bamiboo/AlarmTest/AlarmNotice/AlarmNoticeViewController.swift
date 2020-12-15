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
    
    // test
    private var selectedIndexPath: IndexPath!
    
    
    // MARK: Views
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: TitleView.TITLE_VIEW_HEIGHT)
        layout.estimatedItemSize = CGSize(width: view.bounds.width, height: 100)
        
        let collcetionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collcetionView.translatesAutoresizingMaskIntoConstraints = false
        collcetionView.register(AlarmNoticeCell.self, forCellWithReuseIdentifier: reusableIdentifier)
//        collcetionView.contentInsetAdjustmentBehavior = .never
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
    func collectionViewInvalidateLayout() {
        contentCollectionView.collectionViewLayout.invalidateLayout()
    }
}

extension AlarmNoticeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! AlarmNoticeCell
        cell.setData(data: viewModel.dataSource[indexPath.row])
        cell.setCellState(isOpen: viewModel.isOpened[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        viewModel.itemTapped(indexPath.row)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AlarmNoticeCell {
            if self.viewModel.isOpened[indexPath.row] {
                // set open
                // : set shown -> expand height
                cell.setCellState(isOpen: true)
                collectionView.performBatchUpdates({
                    collectionView.collectionViewLayout.invalidateLayout()
                })
            } else {
                // set close
                // : shrink height -> set hidden
                collectionView.performBatchUpdates({
                    collectionView.collectionViewLayout.invalidateLayout()
                }, completion: { _ in
                    cell.setCellState(isOpen: false)
                })
            }
        }
    }
}

extension AlarmNoticeViewController: UICollectionViewDelegate {
}

extension AlarmNoticeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = UIDevice.current.orientation.isLandscape ? collectionView.bounds.height : collectionView.bounds.width
        let isOpened = viewModel.isOpened[indexPath.row]
        
        /*
        if let cell = collectionView.cellForItem(at: indexPath) as? AlarmNoticeCell {
            if selectedIndexPath == nil {
                return CGSize(width: cellWidth, height: cell.getClosedHeight()) // 초기 cell 사이즈
            } else {
                if selectedIndexPath == indexPath {
                    return CGSize(width: cellWidth, height: isOpened ? cell.getOpenedHeight() : cell.getClosedHeight()) // 클릭한 cell resizing
                } else {
                    return cell.frame.size // 클릭하지 않은 cell 은 size 유지
                }
            }
        } else { // cell 이 화면에서 사라지는 시점(= reusableQueue 에 enqueue 되는 시점) 에는 cell 변수 값이 nil 이다!!!!
            /*
             결국에는 open / close 상태에 따른 예상 height 를 계산해서 높이를 유지해줘야하는데... 어차피 이렇게 계산할거면... stackView 왜쓴거집 ㅎㅅㅎ;;;
             */
            let attrTitleString = NSAttributedString(string: viewModel.dataSource[indexPath.row].title, attributes: AlarmNoticeCell.titleAttribute)
            let estTitleTextSize = attrTitleString.boundingRect(with: CGSize(width: cellWidth, height: CGFloat.infinity), options: [.usesLineFragmentOrigin, .usesFontLeading], context:nil).size
            let attrTimeString = NSAttributedString(string: viewModel.dataSource[indexPath.row].time, attributes: AlarmNoticeCell.timeAttribute)
            let estTimeTextSize = attrTimeString.boundingRect(with: CGSize(width: cellWidth, height: CGFloat.infinity), options: [.usesLineFragmentOrigin, .usesFontLeading], context:nil).size
            let titleViewHeight = estTitleTextSize.height + estTimeTextSize.height + 8 * 3
            if isOpened {
                let attrContString = NSAttributedString(string: viewModel.dataSource[indexPath.row].contents, attributes: AlarmNoticeCell.contentAttribute)
                let estContTextSize = attrContString.boundingRect(with: CGSize(width: cellWidth, height: CGFloat.infinity), options: [.usesLineFragmentOrigin, .usesFontLeading], context:nil).size
                let contentViewHeight = estContTextSize.height + 8 * 2 + 1
                return CGSize(width: cellWidth, height: titleViewHeight + contentViewHeight) // 초기 cell 사이즈
            } else {
                return CGSize(width: cellWidth, height: titleViewHeight) // 초기 cell 사이즈
            }
        }
        */
        
       let attrTitleString = NSAttributedString(string: viewModel.dataSource[indexPath.row].title, attributes: AlarmNoticeCell.titleAttribute)
       let estTitleTextSize = attrTitleString.boundingRect(with: CGSize(width: cellWidth, height: CGFloat.infinity), options: [.usesLineFragmentOrigin, .usesFontLeading], context:nil).size
       let attrTimeString = NSAttributedString(string: viewModel.dataSource[indexPath.row].time, attributes: AlarmNoticeCell.timeAttribute)
       let estTimeTextSize = attrTimeString.boundingRect(with: CGSize(width: cellWidth, height: CGFloat.infinity), options: [.usesLineFragmentOrigin, .usesFontLeading], context:nil).size
       let titleViewHeight = estTitleTextSize.height + estTimeTextSize.height + 8 * 3
       if isOpened {
           let attrContString = NSAttributedString(string: viewModel.dataSource[indexPath.row].contents, attributes: AlarmNoticeCell.contentAttribute)
           let estContTextSize = attrContString.boundingRect(with: CGSize(width: cellWidth, height: CGFloat.infinity), options: [.usesLineFragmentOrigin, .usesFontLeading], context:nil).size
           let contentViewHeight = estContTextSize.height + 8 * 2 + 1
           return CGSize(width: cellWidth, height: titleViewHeight + contentViewHeight) // 초기 cell 사이즈
       } else {
           return CGSize(width: cellWidth, height: titleViewHeight) // 초기 cell 사이즈
       }
    }
}
