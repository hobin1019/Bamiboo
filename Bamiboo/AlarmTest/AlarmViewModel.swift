//
//  SwipeViewControllerModel.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import UIKit


// MARK: PAGE_MOVE_STATE
enum PAGE_MOVE_STATE {
    case prev, next
}


// MARK: AlarmViewControllerDelegate
protocol AlarmViewControllerDelegate: class {
    func disappearPage()
    func scrollPage()
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


// MARK: AlarmViewControllerModel
class AlarmViewControllerModel {
    weak var delegate: AlarmViewControllerDelegate!
    
    let allPageStates: [ALARM_PAGE_STATE] = [.myNews, .waitForFree, .notice] // let 이라 public 이어도 됨
    private(set) var nowPageState: Int = 0 {
        willSet { delegate.disappearPage() }
        didSet { delegate.scrollPage() }
    }
    
    
    // MARK: Public Functions
    func setNowPageState(_ state: PAGE_MOVE_STATE) {
        if state == .prev && nowPageState > allPageStates.indices.first! {
            nowPageState = nowPageState - 1
        } else if state == .next && nowPageState < allPageStates.indices.last! {
            nowPageState = nowPageState + 1
        }
    }
    func setNowPageState(_ index: Int) {
        if index < 0 || index >= allPageStates.count { return }
        nowPageState = index
    }
    
    
}
