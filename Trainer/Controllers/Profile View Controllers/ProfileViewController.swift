//
//  ProfileViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .appPrimaryColor
        
        return view
    }()
    
    let searchBar: UISearchBar = {
        let name = "James"
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .minimal
        bar.placeholder = "Search \(name)' profile"
        
        // This is very sus, may be rejected from App Store since these aren't public
        let textFieldInsideSearchBar = bar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.5)
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = .white
        
        return bar
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "zac_perna")
        imageView.layer.cornerRadius = Constants.ProfileScreen.PROFILE_IMAGE_HEIGHT / 2
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let memberInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let memberInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Trainer since 2019"
        
        return label
    }()
    
    let profileNameView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "James Atlin"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        configureViews()
    }
    
    private func configureViews() {
        // Add a search bar above the profile image to make the profile searchable
        configureHeaderView()
        configureUserInfoView()
    }
    
    private func configureHeaderView() {
        view.addSubview(profileHeaderView)
        view.addSubview(searchBar)
        view.addSubview(memberInfoView)
        view.addSubview(profileImageView)
        
        profileHeaderView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 155)
        
        searchBar.anchor(top: profileHeaderView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 30, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        memberInfoView.anchor(top: profileHeaderView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: profileImageView.leadingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        
        profileImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 155).isActive = true
        profileImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: Constants.ProfileScreen.PROFILE_IMAGE_WIDTH, height: Constants.ProfileScreen.PROFILE_IMAGE_HEIGHT)
        
        configureMemberInfoView()
    }
    
    private func configureMemberInfoView() {
        memberInfoView.addSubview(memberInfoLabel)
        
        memberInfoLabel.anchor(top: memberInfoView.topAnchor, leading: memberInfoView.leadingAnchor, bottom: nil, trailing: memberInfoView.trailingAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
    }
    
    private func configureUserInfoView() {
        view.addSubview(profileNameView)
        
        profileNameView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileNameView.anchor(top: profileImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }

}
