//
//  PostBottomSheetViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/2/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit
import FloatingPanel

class PostBottomSheetViewController: UIViewController {
    
    var controllerDelegate: FloatingPanelController?
    
    private let createPostLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Create a Post"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        label.sizeToFit()
        
        return label
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 18)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubViews()
        configureGestureRecognizers()
    }
    
    private func configureGestureRecognizers() {
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTextViewKeyboard))
        //        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureSubViews() {
        configureCreatePostLabel()
        configureTextView()
    }
    
    private func configureCreatePostLabel() {
        view.addSubview(createPostLabel)
        createPostLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
    }
    
    private func configureTextView() {
        view.addSubview(textView)
        textView.delegate = self
        textView.anchor(top: createPostLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    // MARK: - Selectors
    
    @objc private func dismissTextViewKeyboard() {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        }
        
        let nextPosition = getNextFloatingPanelPosition()
        showKeyboardIfNeeded(forPosition: nextPosition)
        controllerDelegate?.move(to: nextPosition, animated: true)
    }
    
    private func getNextFloatingPanelPosition() -> FloatingPanelPosition {
        if let rawValue = controllerDelegate?.position.rawValue {
            if let position = FloatingPanelPosition(rawValue: rawValue - 1) {
                return position
            }
        }
        return .full
    }
    
    private func showKeyboardIfNeeded(forPosition position: FloatingPanelPosition) {
        if position == .full {
            textView.becomeFirstResponder()
        }
    }
    
}

extension PostBottomSheetViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if controllerDelegate?.position != .full {
            controllerDelegate?.move(to: .full, animated: true)
        }
    }
    
}
