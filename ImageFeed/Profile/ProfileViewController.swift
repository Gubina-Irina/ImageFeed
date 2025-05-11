//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Irina Gubina on 05.05.2025.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    private var profilePhotoImageView: UIImageView!
    private var nameLabel: UILabel!
    private var loginNameLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var logoutButton: UIButton!
    
    // MARK: - ProfileData
    private var profileData = ProfileData(name: "Екатерина Новикова",
                                          login: "@ekaterina_nov",
                                          description: "Hello, world!",
                                          profileAvatar: "profilePhoto") {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(named: "YP Black (iOS)")
                tabBarController?.tabBar.standardAppearance = appearance
                tabBarController?.tabBar.scrollEdgeAppearance = appearance
            }
        
        configureView()
        setupUI()
    }
    
    // MARK: - Actions
    @objc func didTapLogoutButton() {}
    
    // MARK: - Public Methods
    func updateProfile(name: String? = nil, login: String? = nil, description: String? = nil) {
        if let name = name { profileData.name = name }
        if let login = login { profileData.login = login }
        if let description = description { profileData.description = description }
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setupProfilePhoto()
        setupName()
        setupLoginName()
        setupDescription()
        setupLogoutButton()
        setupConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(named: "YP Black (iOS)")
    }
    
    private func updateUI() {
        nameLabel.text = profileData.name
        loginNameLabel.text = profileData.login
        descriptionLabel.text = profileData.description
    }
    
    private func setupProfilePhoto() {
        let profileImage = UIImage(named: profileData.profileAvatar)
        profilePhotoImageView = UIImageView(image: profileImage)
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profilePhotoImageView)
    }
    
    private func setupName() {
        nameLabel = UILabel()
        nameLabel.text = profileData.name
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = UIColor(named: "YP White (iOS)")
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
    }
    
    private func setupLoginName() {
        loginNameLabel = UILabel()
        loginNameLabel.text = profileData.login
        loginNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        loginNameLabel.textColor = UIColor(named: "YP Gray (iOS)")
        
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLabel)
    }
    
    private func setupDescription() {
        descriptionLabel = UILabel()
        descriptionLabel.text = profileData.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.textColor = UIColor(named: "YP White (iOS)")
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
    }
    
    private func setupLogoutButton() {
        logoutButton = UIButton.systemButton(
            with: UIImage(named: "exit")!,
            target: self,
            action: #selector (Self.didTapLogoutButton))
        logoutButton.tintColor = UIColor(named: "YP Red (iOS)")
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Profile Photo
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: 70),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: 70),
            profilePhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:32),
            profilePhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Name Label
            nameLabel.leadingAnchor.constraint(equalTo: profilePhotoImageView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 8),
            
            //Login Name
            loginNameLabel.leadingAnchor.constraint(equalTo: profilePhotoImageView.leadingAnchor),
            loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            // Description
            descriptionLabel.leadingAnchor.constraint(equalTo: profilePhotoImageView.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8),
            
            //Logout Button
            logoutButton.widthAnchor.constraint(equalToConstant: 44),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.centerYAnchor.constraint(equalTo: profilePhotoImageView.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}
