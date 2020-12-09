//
//  SwipeViewControllerModel.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import Foundation


// MARK: Enum
enum PAGE_MOVE_STATE {
    case prev, next
}

// MARK: SwipeViewControllerDelegate
protocol SwipeViewControllerDelegate: class {
    func movePage()
}


// MARK: ALARM_PAGE_STATE
enum ALARM_PAGE_STATE: String {
    case myNews         = "내 소식"
    case waitForFree    = "기다리면 무료"
    case notice         = "공지사항"
}


// MARK: SwipeViewControllerModel
class SwipeViewControllerModel {
    weak var delegate: SwipeViewControllerDelegate!
    
    private let allPageStates: [ALARM_PAGE_STATE] = [.myNews, .waitForFree, .notice]
    private var nowPageState: Int = 0 {
        didSet { delegate.movePage() }
    }
    
    func getAllPageStates() -> [ALARM_PAGE_STATE] {
        return allPageStates
    }
    func getNowPageState() -> Int {
        return nowPageState
    }
    func setNowPageState(_ state: PAGE_MOVE_STATE) {
        if state == .prev && nowPageState > allPageStates.indices.first! {
            nowPageState = nowPageState - 1
        } else if state == .next && nowPageState < allPageStates.indices.last! {
            nowPageState = nowPageState + 1
        }
    }
    
    
}
