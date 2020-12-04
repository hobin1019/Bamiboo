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
 
 외부요인 >> ex) 화면 회전에 따라 화면 중앙에 위치하도록
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
 
 
 # Default Value
 interface 에서 UIView 의 default Autoresizing Mask 값은 [.flexibleRightMargin, .flexibleBottomMargin]
 code 상에서 생성한 UIView 의 defaul Autoresizing Mask 값은 none
 
 
 ?? 궁금한 점 ?? (😃 해결)
 translatesAutoresizingMaskIntoConstraints: Bool
 interface 에서 UIView 의 Auto Layout 프로퍼티를 설정해주면, 자동으로 false 값으로 세팅되지만
 code 상에서 생성된 UIView 의 translatesAutoresizingMaskIntoConstraints 의 default 값은 true 이다
    i) true
        autoresizing mask 값을 이용해 constraints 집합을 생성해내며, 그 집합은 view 의 위치&사이즈를 완벽히 지정
    ii) false
        autoresizing mask 값으로 constraints 집합을 생성하지 않기 때문에, 개발자가 view 의 위치&사이즈를 완벽히 명시해주어야함
 
 
 ?? 궁금한 점 ?? (🤨 확인 필요)
 Interface에서 Autoresizing Mask 를 이용하려고 하면,
 left margin, right margin, top margin, bottom margin 값에 대해서는 selected 된 속성이 fixed 로 설정되는데,
 왜?? width, height 값에 대해서는 selected 된 속성이 flexible 로 설정되는 것일까?
 (추측) interface 를 보면 margin 은 '|-|' 모양이고, width 와 height 는 '<->' 모양이다! 각각이 fixed, flexible을 의미하는게 아닐까?
 
 
 ?? 궁금한 점 ?? (😃 해결)
 leftMargin, rightMargin 을 모두 fixed 로 설정하면, leftMargin 만 적용되고
 topMargin, bottomMargin 을 모두 fixed 로 설정하면, topMargin 만 적용되는 것 같다?
 (? 우선순위가 leftMargin > rightMargin 이고 topMargin > bottomMargin 인듯하다)
 autoresizing mask 를 이용해 view 를 superview 의 정가운데에 위치시키려면 어떻게 해야하는가??
 (flexibleLeftMargin, flexibleRightMargin, flexibleTopMargin, flexibleBottomMargin 을 될것 같은데 ㅎㅅㅎ 왜 안되지??)
 interface 에서도 left/right 둘중 하나만 먹음 (왜떄문에 ㅠㅜㅠㅜ)
 =>> 초기 frame 위치를 .zero로 설정했기 떄문 (comment 01, 02 참고)
 
 */
class LayoutAutoresizingMaskViewController: UIViewController {
    class OrangeView: UIView {
        override func layoutSubviews() {
            super.layoutSubviews()
        }
    }
    final let MAX_VIEW_SIZE: CGFloat = 300
    
    // UIViews
    var orangeView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(orangeView)
        orangeView.backgroundColor = .orange
        
        orangeView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 300)) // [comment 01]
        orangeView.center = view.center // [comment 02]
        print(orangeView.autoresizingMask) // rawValue : 0 (0b000_000)
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin] // <-- mask(C bit) 값을 OR 연산자로 처리
        print(orangeView.autoresizingMask) // rawValue : 45 (0b101_101)
    }

}
