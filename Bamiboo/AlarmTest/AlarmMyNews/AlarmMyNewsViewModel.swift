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
    
    var dataSource: [AlarmMyNewsItem] = [] {
        didSet { delegate.reloadCollectionView() }
    }
    
    func requestDataSource() {
        /* TODO
         nw_protocol_get_quic_image_block_invoke dlopen libquic failed 오류가 종종 남
         이미지 순서가 안맞게 뿌려질 때가 있읔
         */
        dataSource = [
            AlarmMyNewsItem(title: "title1\nsubtitle1", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.09"),
            AlarmMyNewsItem(title: "title2\nsubtitle2", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.03"),
            AlarmMyNewsItem(title: "title3\nsubtitle3", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.20"),
            AlarmMyNewsItem(title: "title1\nsubtitle1", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.09"),
            AlarmMyNewsItem(title: "title2\nsubtitle2", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.03"),
            AlarmMyNewsItem(title: "title3\nsubtitle3", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.20"),
            AlarmMyNewsItem(title: "title1\nsubtitle1", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.09"),
            AlarmMyNewsItem(title: "title2\nsubtitle2", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.03"),
            AlarmMyNewsItem(title: "title3\nsubtitle3", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.20"),
            AlarmMyNewsItem(title: "title1\nsubtitle1", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.09"),
            AlarmMyNewsItem(title: "title2\nsubtitle2", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.03"),
            AlarmMyNewsItem(title: "title3\nsubtitle3", imageUrl: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.20"),
        ]
    }
}
