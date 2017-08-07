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
            
            tableView.rowHeight = 60
            tableView.sectionHeaderHeight = 40
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        loadTableHeaderView()
        
        loadTableFooterView()
    }
    

    private var layoutPageView = false
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if !layoutPageView {
            layoutPageView = true
            
            var frame = view.bounds
            frame.size.height = 200
            headerViewController.view.frame = frame
            tableView.tableHeaderView = headerViewController.view
            
            showIndicatorIfNeeded()
        }
        
        if self.headerViewController.pageImageFiles.count == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.headerViewController.pageImageFiles = ["city", "wall", "castle"]
                self.headerViewController.pageTitles = ["Page 0", "Page 1", "Page 2"]
                
                self.indicator?.stopAnimating()
            }
        }
    }
    
    // MARK: - Helper
    
    private let loadImmediately = false     // For test
    private func loadTableHeaderView() {
        headerViewController = PageContainerController(useTimer: true,
                                                       recursive: true,
                                                       showTitle: true)
        headerViewController.delegate = self

        if loadImmediately {
            headerViewController.pageImageFiles = ["city", "wall", "castle"]
            headerViewController.pageTitles = ["Page 0", "Page 1", "Page 2"]
        }
        
        addChildViewController(headerViewController)
        
        headerViewController.didMove(toParentViewController: self)
    }
    
    private func loadTableFooterView() {
        let footerView = UIView()
        var frame = UIScreen.main.bounds
        frame.size.height = 100
        footerView.frame = frame
        let label = UILabel(frame: frame)
        label.text = "Table Footer View"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        footerView.addSubview(label)
        footerView.backgroundColor = UIColor.lightGray
        tableView.tableFooterView = footerView
    }
    
    private var indicator: UIActivityIndicatorView!
    private func showIndicatorIfNeeded() {
        if headerViewController.pageImageFiles.count == 0 {
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
        vc.title = "Page \(page)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Table view  dataSource

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

// MARK: - Table view  delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIViewController()
        vc.title = "\(indexPath)"
        vc.view.backgroundColor = UIColor.white
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

