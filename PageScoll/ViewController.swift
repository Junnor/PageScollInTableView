//
//  ViewController.swift
//  PageScoll
//
//  Created by nyato on 2017/8/4.
//  Copyright © 2017年 nyato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var headerViewController: PageContainerController!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.rowHeight = 77
            tableView.sectionHeaderHeight = 50
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        
        
        configureContainerViewController()
    }
    
    private func configureContainerViewController() {
        headerViewController = PageContainerController(useTimerAnimation: false, allowedRecursive: false)
        
        headerViewController.imagesName = ["0", "1", "2"]
        headerViewController.pagesTitle = ["Page 0", "Page 1", "Page 2"]
        
        headerViewController.delegate = self        
        
        addChildViewController(headerViewController)
                
        var frame = UIScreen.main.bounds
        frame.origin.y = 0
        frame.size.height = 200
        headerViewController.view.frame = frame
        
        tableView.tableHeaderView = headerViewController.view
        
        let footerView = UIView()
        frame.size.height = 100
        footerView.frame = frame
        let label = UILabel(frame: frame)
        label.text = "Table Footer View"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        footerView.addSubview(label)
        footerView.backgroundColor = UIColor.lightGray
        tableView.tableFooterView = footerView

        headerViewController.didMove(toParentViewController: self)
        
        showIndicatorIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
//            
//            print("perfrom long long ago")
//            
//            self.headerViewController.imagesName = ["0", "1", "2"]
//            self.headerViewController.pagesTitle = ["Page 0", "Page 1", "Page 2"]
//            
//            self.indicator?.stopAnimating()
//        }
    }
    
    
    private var indicator: UIActivityIndicatorView!
    private func showIndicatorIfNeeded() {
        if headerViewController.imagesName.count == 0 {
            indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            indicator.center = tableView.tableHeaderView!.center
            tableView.tableHeaderView?.addSubview(indicator)
            tableView.tableHeaderView?.addSubview(indicator)
            
            indicator.startAnimating()
        }
    }

}

// MARK: - pageContainer delegate

extension ViewController: PageContainerControllerDelegate {
    
    func pageContainerController(_ controller: PageContainerController, didSelectedAt page: Int) {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        vc.title = "\(page)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section) Header"
    }

    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "\(section) Footer"
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIViewController()
        vc.title = "\(indexPath)"
        vc.view.backgroundColor = UIColor.white
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

