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
            AlarmWaitForFreeItem(title: "해골병사는 던전을 지키지 못했다", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.09", readable: true),
            AlarmWaitForFreeItem(title: "나 혼자만 레벨업나 혼자만 레벨업나 혼자만 레벨업나 혼자만 레벨업나 혼자만 레벨업나 혼자만 레벨업", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.15", readable: false),
            AlarmWaitForFreeItem(title: "이태원 클라쓰", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.16", readable: true),
            AlarmWaitForFreeItem(title: "여성향 게임의 파멸 플래그 밖에 없는 악역의 역할로 환생해 버렸다", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.20", readable: false),
            AlarmWaitForFreeItem(title: "나는 이 집 아이", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.23", readable: true),
        ]
    }
}

