//
//  AppDelegate.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/02.
//

import UIKit

/*
 main 함수는 기본적으로 UIApplication 클래스의 인스턴스를 만들어서 GUI를 사용하기 위한 런루프를 돌려주는 작업을 수행
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /* MARK: UIWindow
         
         뷰들을 담는 컨테이너
         스크린에 표시되는 뷰의 계층 구조에서 최상위 뷰의 역할을 할 고정적인 객체의 역할 */
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        // Window는 단순 시각적으로 보여주는 뷰 컨테이너이기 때문에 반드시 rootViewController 를 지정해줘야한다
        let rootVC = MainViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navVC
        
        /*
         ?? key window 로 지정
            해당 윈도우를 key window 로 지정하겠다는 의미이며,
            key window로 지정되면 touch를 제외한 키보드 이벤트 / non-touch 이벤트들이 해당 window 로 넘어오게 된다
            (touch 이벤트는 touch가 일어난 window 로 이벤트를 넘겨줌)
         
         ?? visible 하게 설정
            해당 window 를 맨 앞으로 보여주겠다는 의미
         */
        print(window.isKeyWindow)
        window.makeKeyAndVisible()
        print(window.isKeyWindow)
        
        
        // Main.storyboard 를 이용해 자동으로 UIWindow 객체가 생성되는 경우에는 인스턴스에 자동으로 window 가 지정되기 때문에 생략할 수 있다
        self.window = window
        
        print(UIScreen.main.bounds)
        
        
        
        // MARK: appearance()
        // appearance 를 이용하면 전체 UI에 대해 공통 설정을 해줄 수 있다!!
        /*
        UIButton.appearance().tintColor = .red
        UIView.appearance().backgroundColor = .green
        */
        
        return true
    }

}

