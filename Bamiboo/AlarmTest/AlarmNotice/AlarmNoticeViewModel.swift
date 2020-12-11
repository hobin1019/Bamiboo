//
//  AlarmNoticeViewModel.swift
//  Bamiboo
//
//  Created by 한호빈 on 2020/12/11.
//

import Foundation


protocol AlarmNoticeViewDelegate: class {
    func reloadContentsView()
}

class AlarmNoticeViewModel {
    weak var delegate: AlarmNoticeViewDelegate!
    
    private(set) var dataSource: [AlarmNoticeItem] = [] {
        didSet {
            isOpened.removeAll()
            delegate.reloadContentsView()
        }
    }
    private(set) var isOpened: Set<Int> = Set()
    
    
    // MARK: Public Functions
    func addOpenView(_ idx: Int) {
        isOpened.insert(idx)
    }
    
    func requestDataSource() {
        dataSource = [
            AlarmNoticeItem(title: "'헤어져도 될까요?' 서비스 종료 안내 0", time: "2020.12.11 00:00:00", contents:
"""
안녕하세요.
카카오웹툰 운영팀입니다.

2020.09.20
"""
            ),
            AlarmNoticeItem(title: "'헤어져도 될까요?' 서비스 종료 안내 1", time: "2020.12.11 00:00:00", contents:
"""
안녕하세요.
카카오웹툰 운영팀입니다.

8월 20일(토) 16시경부터 8월 21일(일) 오전.
신규 회차 업데이트 알림 미송신 현상이 발생하여 관련 공지 드립니다.

일부 서버 이슈로 인해 업데이트 알림이 정상적으로 수신되지 않았으나 21일(일) 오전 10시경 해당 문제가 해결되어
현재에는 정상적으로 알림 수신 가능한 점 안내 드립니다.

신규 회차 업데이트 알림 미송신으로,
서비스 이용에 불편을 드려 죄송합니다.

보다 안정적인 서비스를 위해 끊임없이 노력하는 카카오웹툰이 되겠습니다.
카카오웹툰 운영팀 드림

2020.09.20
"""
            ),
            AlarmNoticeItem(title: "'헤어져도 될까요?' 서비스 종료 안내 \nhihi 2\nhello it`s title", time: "2020.12.11 00:00:00", contents:
"""
안녕하세요.
카카오웹툰 운영팀입니다.

8월 20일(토) 16시경부터 8월 21일(일) 오전.
신규 회차 업데이트 알림 미송신 현상이 발생하여 관련 공지 드립니다.

일부 서버 이슈로 인해 업데이트 알림이 정상적으로 수신되지 않았으나 21일(일) 오전 10시경 해당 문제가 해결되어
현재에는 정상적으로 알림 수신 가능한 점 안내 드립니다.

신규 회차 업데이트 알림 미송신으로,
서비스 이용에 불편을 드려 죄송합니다.

보다 안정적인 서비스를 위해 끊임없이 노력하는 카카오웹툰이 되겠습니다.
카카오웹툰 운영팀 드림

2020.09.20
"""
            ),
            AlarmNoticeItem(title: "'헤어져도 될까요?' 서비스 종료 안내 3", time: "2020.12.11 00:00:00", contents:
"""
안녕하세요.
카카오웹툰 운영팀입니다.

8월 20일(토) 16시경부터 8월 21일(일) 오전.
신규 회차 업데이트 알림 미송신 현상이 발생하여 관련 공지 드립니다.

일부 서버 이슈로 인해 업데이트 알림이 정상적으로 수신되지 않았으나 21일(일) 오전 10시경 해당 문제가 해결되어
현재에는 정상적으로 알림 수신 가능한 점 안내 드립니다.

신규 회차 업데이트 알림 미송신으로,
서비스 이용에 불편을 드려 죄송합니다.

보다 안정적인 서비스를 위해 끊임없이 노력하는 카카오웹툰이 되겠습니다.
카카오웹툰 운영팀 드림

2020.09.20
"""
            ),
        ]
    }
}
