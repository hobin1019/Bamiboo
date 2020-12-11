//
//  AlarmWaitForFreeViewModel.swift
//  Bamiboo
//
//  Created by 한호빈 on 2020/12/11.
//

import Foundation

protocol AlarmWaitForFreeViewDelegate: class {
    func reloadCollectionView()
}

class AlarmWaitForFreeViewModel {
    weak var delegate: AlarmWaitForFreeViewDelegate!
    
    var dataSource: [AlarmWaitForFreeItem] = [] {
        didSet { delegate.reloadCollectionView() }
    }
    
    func requestDataSource() {
        dataSource = [
            AlarmWaitForFreeItem(title: "title1\nsubtitle1", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.09"),
        ]
    }
}

