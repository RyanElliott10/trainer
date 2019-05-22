//
//  PostPanModalViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/17/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit
import PanModal

class PostPanModalViewController: UIViewController, PanModalPresentable {
    
    var panScrollable: UIScrollView?
    var shortFormHeight: PanModalHeight {
        return .contentHeight(250)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    
    let createPostLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Create a Post"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        
        return label
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 18)
        view.backgroundColor = .yellow
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureViews()
    }
    
    private func configureViews() {
        view.addSubview(createPostLabel)
        view.addSubview(textView)
        createPostLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        textView.anchor(top: createPostLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: view.frame.height - 400)
    }
    
}
