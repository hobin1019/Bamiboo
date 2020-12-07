//
//  ViewController.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/02.
//

import UIKit

struct ViewControllerItem {
    var vc: UIViewController
    var title: String
}

let viewControllerList: [ViewControllerItem] = [
    ViewControllerItem(vc: LayoutFrameMaskViewController(), title: "Layout, Frame"),
    ViewControllerItem(vc: LayoutAutoresizingMaskViewController(), title: "Layout, Autoresizing Mask"),
    ViewControllerItem(vc: LayoutConstraintViewController(), title: "Layout, Constraint"),
    ViewControllerItem(vc: AutoLayoutStackViewViewController(), title: "Layout, without Constraints (UIStackView)"),
    ViewControllerItem(vc: iOSLayoutViewController(), title: "Layout, Top-Bottom Layout Guide & Safe Area"),
    ViewControllerItem(vc: TestViewController(), title: "Test UIKit"),
]

class MainViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainVCCellId", for: indexPath)
        cell.textLabel?.text = viewControllerList[indexPath.row].title
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let destVC: UIViewController = viewControllerList[indexPath.row].vc
        navigationController?.pushViewController(destVC, animated: true)
    }
}
