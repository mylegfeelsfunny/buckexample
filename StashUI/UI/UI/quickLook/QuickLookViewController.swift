//
//  QuickLookViewController.swift
//  StashUI
//
//  Created by Kenny Sanchez on 12/12/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import QuickLook

protocol QuickLookViewInterface: class {}

class QuickLookViewController: QLPreviewController {
    
    var presenter: QuickLookPresenterInterface?
    let previewItem = QuickLookPreviewItem()
    
    init(url: URL, title: String) {
        self.previewItem.previewItemTitle = title
        self.previewItem.previewItemURL   = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQLPreviewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSolidNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupQLPreviewController() {
        self.delegate = self
        self.dataSource = self
        self.currentPreviewItemIndex = 0
        
        let image   = Image.dismissButtonWhite.image
        let style   = UIBarButtonItemStyle.plain
        let target  = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: style, target: target, action: #selector(self.dismissButtonTapped))
    }
    
    @objc func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension QuickLookViewController: QLPreviewControllerDelegate {
    
    public func previewController(_ controller: QLPreviewController, shouldOpen url: URL, for item: QLPreviewItem) -> Bool {
        return true
    }
}

extension QuickLookViewController: QLPreviewControllerDataSource {
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return previewItem
    }
}

extension QuickLookViewController: QuickLookViewInterface {
}

