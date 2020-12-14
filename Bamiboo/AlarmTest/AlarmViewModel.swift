//
//  SwipeViewControllerModel.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import UIKit


// MARK: PAGE_MOVE_STATE
enum PageMoveState {
    case prev, next
}


// MARK: AlarmViewDelegate
protocol AlarmViewDelegate: class {
    func contentViewWillDisappear()
    func contentViewWillAppear()
}


// MARK: ALARM_PAGE_STATE
enum AlarmPageState: CaseIterable {
    case myNews, waitForFree, notice
    
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


// MARK: AlarmViewModel
class AlarmViewModel {
    weak var delegate: AlarmViewDelegate!
    
    let allPageStates: [AlarmPageState] = AlarmPageState.allCases
    private(set) var nowPageState: Int = 0 {
        willSet { delegate.contentViewWillDisappear() }
        didSet { delegate.contentViewWillAppear() }
    }
    
    
    // MARK: Public Functions
    func setNowPageState(_ state: PageMoveState) {
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
