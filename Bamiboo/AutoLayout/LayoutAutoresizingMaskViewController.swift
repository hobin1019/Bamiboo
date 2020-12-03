//
//  LayoutAutoresizingMaskViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/03.
//

import UIKit

/*
 [Understanding Auto Layout]
 3. Autoresizing Mask로 구현해보기
 (문서) https://developer.apple.com/documentation/uikit/uiview/1622559-autoresizingmask
 
 외부요인 >> ex) 화면 회전 / slider 값에 따라 화면 중앙에 위치하도록
 내부요인 >> ex) slider 값에 따라 사이즈가 조정되도록...? >> 불가능!! superview 에 대해서면 상대적으로 조정이 가능하기 때문에
 
 ----------------------------------------------------
 
 # Autoresizing Mask
 - fixed(selected in interface) / flexible(unselected in interface)
 - flexible attribute로 지정되었다면, behave auto resizing views when superview's size changes(proportionally)
   => superview 의 사이즈에는 유기적으로 사이즈를 변환해줄 수 있지만, 해당 뷰 자체 / subview의 사이즈 변화에 대해서는 대응할 수 없다는 단점이 있다!!
 - 종류 : left margin, right margin, top margin, bottom margin, width, heigth
 
 
 # Mask?
 Layer 기반의 렌더링시스템에서 사용하는 용어
       (option)                 (mask)
 flexible left margin       >>  0b000_001
 flexible width             >>  0b000_010
 flexible right margin      >>  0b000_100
 flexible top margin        >>  0b001_000
 flexible height            >>  0b010_000
 flexible bottom margin     >>  0b100_000
 
 
 ?? 궁금한 점 ??
 Interface에서 Autoresizing Mask 를 이용하려고 하면,
 left margin, right margin, top margin, bottom margin 값에 대해서는 selected 된 속성이 fixed 로 설정되는데,
 왜?? width, height 값에 대해서는 selected 된 속성이 flexible 로 설정되는 것일까?
 
 ?? 궁금한 점 ??
 leftMargin, rightMargin 을 모두 fixed 로 설정하면, leftMargin 만 적용되고
 topMargin, bottomMargin 을 모두 fixed 로 설정하면, topMargin 만 적용되는 것 같다?
 (? 우선순위가 leftMargin > rightMargin 이고 topMargin > bottomMargin 인듯하다)
 
 ?? 궁금한 점 ??
 interface 에서 UIView 의 default Autoresizing Mask 값은 [.flexibleRightMargin, .flexibleBottomMargin] 인것 같은데
 code 상에서 생성한 UIView 의 defaul Autoresizing Mask 값은 none 이다?
 개발방식이 달라짐에 따라 default 값이 다른 이유는??
 
 */
class LayoutAutoresizingMaskViewController: UIViewController {
    final let MAX_VIEW_SIZE: CGFloat = 300
    
    // UIViews
    var orangeView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(orangeView)
        orangeView.backgroundColor = .orange
        
        orangeView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 300))
        print(orangeView.autoresizingMask) // rawValue : 0 (0b000_000)
        orangeView.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin] // <-- mask(C bit) 값을 OR 연산자로 처리 (ex_ 0b000_100 OR 0b100_000 >> 0b100_100)
        print(orangeView.autoresizingMask) // rawValue : 36 (0b100_100)
    }
}
