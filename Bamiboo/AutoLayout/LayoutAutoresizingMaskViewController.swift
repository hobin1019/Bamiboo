//
//  LayoutAutoresizingMaskViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/03.
//

import UIKit

class LayoutAutoresizingMaskViewController: UIViewController {
    final let MAX_VIEW_SIZE: CGFloat = 300
    
    // UIViews
    var resizableView = UIView()
    var sliderView = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
