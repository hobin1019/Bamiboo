//
//  SwipeViewControllerModel.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import UIKit


// MARK: Enum
enum PAGE_MOVE_STATE {
    case prev, next
}

// MARK: SwipeViewControllerDelegate
protocol SwipeViewControllerDelegate: class {
    func movePage()
}


// MARK: ALARM_PAGE_STATE
enum ALARM_PAGE_STATE: Int {
    case myNews         = 0
    case waitForFree    = 1
    case notice         = 2
    
    func getTitle() -> String {
        switch (self) {
        case .myNews:       return "내 소식"
        case .waitForFree:  return "기다리면 무료"
        case .notice:       return "공지사항"
        }
    }
    func getViewControllerType() -> UIViewController.Type {
        switch (self) {
        case .myNews:       return AlarmMyNewsViewController.self
        case .waitForFree:  return AlarmWaitForFreeViewController.self
        case .notice:       return AlarmNoticeViewController.self
        }
    }
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
