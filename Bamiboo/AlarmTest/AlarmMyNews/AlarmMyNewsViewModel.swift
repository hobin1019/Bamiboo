//
//  AlarmMyNewsViewModel.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/10.
//

import Foundation

protocol AlarmMyNewsViewDelegate: class {
    func collectionViewWillReload()
}

class AlarmMyNewsViewModel {
    weak var delegate: AlarmMyNewsViewDelegate!
    
    var dataSource: [AlarmMyNewsItem] = [] {
        didSet { delegate.collectionViewWillReload() }
    }
    
    func requestDataSource() {
        /* TODO
         nw_protocol_get_quic_image_block_invoke dlopen libquic failed 오류가 종종 남
         Xcode 12.1 & iOS 14.1 에서 발생하는 문제라는 얘기가 있음... 좀 더 찾아보기
         */
        dataSource = [
            AlarmMyNewsItem(title: "영화 승리호 티저 감상 퀴즈 시사회 티켓 당첨자 발표", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.09 00:00:00", readable: false),
            AlarmMyNewsItem(title: "해골병사는 던전을 지키지 못했다어쩌고저쩌고 길게 쓰기\n이용권 3장 선물", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.12.03 00:00:00", readable: true),
            AlarmMyNewsItem(title: "오늘의 미션카드 도착!\n최대 500캐시 선물 받기", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.10.20 00:00:00", readable: true),
            AlarmMyNewsItem(title: "출석 사전 신청하고 최대 1,000캐시 뽑기권 받기", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.12.05 00:00:00", readable: false),
            AlarmMyNewsItem(title: "추석 맞이 출석체크 이벤트 아이폰 12 당첨자 발표", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/cameraman.tif", time: "2020.09.20 00:00:00", readable: false),
            AlarmMyNewsItem(title: "이태원 클라쓰\n이용권 3개 오늘 만료", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", time: "2020.09.03 00:00:00", readable: true),
            AlarmMyNewsItem(title: "카카오톡 친구 초대하면 '브라보 라이언' 이모티콘 선물", thumbnail: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png", time: "2020.08.25 00:00:00", readable: false),
        ].sorted(by: { first, second in
            guard let firstDate = first.getTimeDate(), let secondDate = second.getTimeDate() else { return true }
            return firstDate > secondDate
        })
    }
    
    func readItem(_ index: Int) {
        if !dataSource.indices.contains(index) { return }
        dataSource[index].setRead()
    }
}
