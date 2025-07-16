//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Irina Gubina on 05.05.2025.
//

import UIKit
import Kingfisher

protocol ProfileViewControllerProtocol: AnyObject {
    func configureViews()
    func updateProfileDetails(profile: Profile)
    func showDefaultProfile()
    func setAvatar(url: URL?)
    func showLogoutConfiguration()
}

final class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    
    // MARK: - Private Properties
    private var profilePhotoImageView: UIImageView!
    private var nameLabel: UILabel!
    private var loginNameLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var logoutButton: UIButton!
    
    //private var profileImageServiceObserver: NSObjectProtocol?
    
    private let presenter: ProfileViewPresenterProtocol
    let profileLogoutService = ProfileLogoutService.shared
    
    init(presenter: ProfileViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()
        presenter.setupObservers()
//        setupUI()
//        setupObservers()
//        configureAppearance()
//        loadProfileData()
        
    }
    
    // MARK: - Actions
    
    @objc func didTapLogoutButton() {
        presenter.didTapLogout()
    }
    
    // MARK: - Private Methods
    
    func configureViews() {
            view.backgroundColor = .ypBlackIOS
            setupUI()
           // setupConstraints()
            configureAppearance()
        }
    
    private func configureAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: "YP Black (iOS)")
            tabBarController?.tabBar.standardAppearance = appearance
            tabBarController?.tabBar.scrollEdgeAppearance = appearance
        }
    }
    
     func updateProfileDetails(profile: Profile) {
        nameLabel.text = profile.name
        loginNameLabel.text = profile.loginName
        descriptionLabel.text = profile.bio
    }
    
    func showDefaultProfile() {
       nameLabel.text = "Имя Фамилия"
       loginNameLabel.text = "@username"
       descriptionLabel.text = nil
   }
    
    func setAvatar(url: URL?) {
            profilePhotoImageView.kf.cancelDownloadTask()
            guard let url = url else {
                profilePhotoImageView.image = UIImage(named: "avatar_placeholder")
                return
            }
            
            let processor = RoundCornerImageProcessor(cornerRadius: 61)
            profilePhotoImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "avatar_placeholder"),
                options: [
                    .processor(processor),
                    .transition(.fade(0.3)),
                    .cacheOriginalImage,
                    .keepCurrentImageWhileLoading
                ]
            )
        }
    
    func showLogoutConfiguration() {
        let alert = UIAlertController(
            title: "Пока, пока!",
            message: "Уверены, что хотите выйти?",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: "Нет", style: .cancel)
        )
        alert.addAction(
            UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
                self?.profileLogoutService.logout()
            }
        )
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .ypBlackIOS
        setupProfilePhoto()
        setupName()
        setupLoginName()
        setupDescription()
        setupLogoutButton()
        setupConstraints()
    }
    
     func configureView() {
        view.backgroundColor = UIColor(named: "YP Black (iOS)")
    }
    
    private func setupProfilePhoto() {
        profilePhotoImageView = UIImageView()
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoImageView.layer.cornerRadius = 35
        view.addSubview(profilePhotoImageView)
    }
    
    private func setupName() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = UIColor(named: "YP White (iOS)")
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
    }
    
    private func setupLoginName() {
        loginNameLabel = UILabel()
        loginNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        loginNameLabel.textColor = UIColor(named: "YP Gray (iOS)")
        
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLabel)
    }
    
    private func setupDescription() {
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.textColor = UIColor(named: "YP White (iOS)")
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
    }
    
    private func setupLogoutButton() {
        guard let exitImage = UIImage(named: "exit") else {
            assertionFailure("Failed to load exit image")
            return
        }
        logoutButton = UIButton.systemButton(
            with: exitImage,
            target: self,
            action: #selector (Self.didTapLogoutButton))
        logoutButton.tintColor = UIColor(named: "YP Red (iOS)")
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        logoutButton.accessibilityIdentifier = "exit"
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
