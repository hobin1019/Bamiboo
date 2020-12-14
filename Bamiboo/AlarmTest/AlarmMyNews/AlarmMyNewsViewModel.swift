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
         Xcode 12.1 & iOS 14.1 에서 발생하는 문제라는 얘기가 있음... 좀 더 찾아보기
         */
        dataSource = [
            AlarmMyNewsItem(title: "title1\nsubtitle1", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.09"),
            AlarmMyNewsItem(title: "title2\nsubtitle2", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.03"),
            AlarmMyNewsItem(title: "title3\nsubtitle3", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.20"),
            AlarmMyNewsItem(title: "title1\nsubtitle1", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.05"),
            AlarmMyNewsItem(title: "title2\nsubtitle2", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.06"),
            AlarmMyNewsItem(title: "title3\nsubtitle3", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.19"),
            AlarmMyNewsItem(title: "title1\nsubtitle1", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.09.09"),
            AlarmMyNewsItem(title: "title2\nsubtitle2", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.08.03"),
            AlarmMyNewsItem(title: "title3\nsubtitle3", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.01"),
            AlarmMyNewsItem(title: "title1\nsubtitle1", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.14"),
            AlarmMyNewsItem(title: "title2\nsubtitle2", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.13"),
            AlarmMyNewsItem(title: "title3\nsubtitle3", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.12"),
        ].sorted(by: { first, second in
            guard let firstDate = first.getDateTime(), let secondDate = second.getDateTime() else { return true }
            return firstDate > secondDate
        })
    }
}
