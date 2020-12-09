//
//  ViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/02.
//

import UIKit

struct CellItem {
    var `class`: UIViewController.Type
    var title: String
}

let viewControllerList: [[CellItem]] = [
    [
        CellItem(class: SwipeViewController.self, title: "스와이핑 테스트"),
        CellItem(class: AlarmViewController.self, title: "내소식 알람 화면"),
    ], [
        CellItem(class: LayoutFrameMaskViewController.self, title: "Layout, Frame"),
        CellItem(class: LayoutAutoresizingMaskViewController.self, title: "Layout, Autoresizing Mask"),
        CellItem(class: LayoutConstraintViewController.self, title: "Layout, Constraint"),
        CellItem(class: AutoLayoutStackViewViewController.self, title: "Layout, without Constraints (UIStackView)"),
        CellItem(class: iOSLayoutViewController.self, title: "Layout, Top-Bottom Layout Guide & Safe Area"),
        CellItem(class: TestViewController.self, title: "Test UIKit"),
        CellItem(class: AnimationViewController.self, title: "Animation"),
    ]
]

class MainViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MainVCCellId")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bamiboo"
        view.backgroundColor = .white
        
        initViews()
    }
    
    private func initViews() {
        // init tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewControllerList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllerList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainVCCellId", for: indexPath)
        cell.textLabel?.text = viewControllerList[indexPath.section][indexPath.row].title
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let destVC: UIViewController = viewControllerList[indexPath.section][indexPath.row].class.init()
        navigationController?.pushViewController(destVC, animated: true)
    }
}
