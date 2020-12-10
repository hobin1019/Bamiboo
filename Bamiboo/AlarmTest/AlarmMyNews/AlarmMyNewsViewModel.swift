//
//  AlarmMyNewsViewModel.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/10.
//

import Foundation

protocol AlarmMyNewsViewDelegate: class {
    func reloadCollectionView()
}

class AlarmMyNewsViewModel {
    weak var delegate: AlarmMyNewsViewDelegate!
    
    var dataSource: [AlarmMyNewsItem] = []
    
    func requestDataSource() {
        dataSource = [
            AlarmMyNewsItem(title: "title1\nsubtitle1", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.09"),
            AlarmMyNewsItem(title: "title2\nsubtitle2", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.03"),
            AlarmMyNewsItem(title: "title3\nsubtitle3", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.20"),
        ]
        delegate.reloadCollectionView()
    }
}
