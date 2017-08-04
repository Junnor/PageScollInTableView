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
    
    init(useTimerAnimation: Bool, allowedRecursive: Bool) {
        super.init(nibName: nil, bundle: nil)
        
        self.useTimerAnimation = useTimerAnimation
        self.allowedRecursive = allowedRecursive
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public

    var hidePageController = false {
        didSet {
            pageViewController?.hidePageController = hidePageController
        }
    }
    
    var usePageTitle = false {
        didSet {
            pageViewController?.usePageTitle = usePageTitle
        }
    }

    var imagesName: [String] = [] {
        didSet {
            pageViewController?.imagesName = imagesName
        }
    }
    var pagesTitle: [String] = [] {
        didSet {
            pageViewController?.pagesTitle = pagesTitle
        }
    }
    
    weak var delegate: PageContainerControllerDelegate?

    // MARK: Private
    
    private var allowedRecursive = true {
        didSet {
            pageViewController?.allowedRecursive = allowedRecursive
        }
    }
    private var useTimerAnimation = true {
        didSet {
            pageViewController?.useTimerAnimation = useTimerAnimation
        }
    }
    
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
        pageViewController?.usePageTitle = usePageTitle

        pageViewController?.imagesName = self.imagesName
        pageViewController?.pagesTitle = self.pagesTitle
    }
    
}

// MARK: - pageView delegate

extension PageContainerController: PageViewControllerDelegate {
    func pageViewController(_ pageViewController: PageViewController, didSelectedAt page: Int) {
        delegate?.pageContainerController(self, didSelectedAt: page)
    }
}
