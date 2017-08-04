//
//  PageContainerController.swift
//  PageControllerContainer
//
//  Created by nyato on 2017/8/3.
//  Copyright © 2017年 nyato. All rights reserved.
//

import UIKit

protocol PageContainerControllerDelegate: class {
    func pageContainerController(_ controller: PageContainerController, didSelectedAt page: Int)
}

class PageContainerController: UIViewController {
    
    
    // MARK: - Public
    var allowedRecursive = true {
        didSet {
            pageViewController?.allowedRecursive = allowedRecursive
        }
    }
    var useTimerAnimation = true {
        didSet {
            pageViewController?.useTimerAnimation = useTimerAnimation
        }
    }

    var hidePageController = false {
        didSet {
            pageViewController?.hidePageController = hidePageController
        }
    }


    var imagesName: [String] = []
    var pagesTitle: [String] = []
    
    weak var delegate: PageContainerControllerDelegate?

    // MARK: Private
    
    private var pageViewController: PageViewController!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = PageViewController()
        pageViewController.delegate = self
        
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pageViewController?.allowedRecursive = self.allowedRecursive
        pageViewController?.hidePageController = self.hidePageController
        pageViewController?.useTimerAnimation = self.useTimerAnimation
        
        pageViewController?.setData((imagesName, pagesTitle))
    }
    
}

// MARK: - pageView delegate

extension PageContainerController: PageViewControllerDelegate {
    func pageViewController(_ pageViewController: PageViewController, didSelectedAt page: Int) {
        delegate?.pageContainerController(self, didSelectedAt: page)
    }
}
