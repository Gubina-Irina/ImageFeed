//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Irina Gubina on 18.05.2025.
//
import UIKit

final class AuthViewController: UIViewController {
    private let oauth2Service = OAuth2Service.shared
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    private let tokenStorage = OAuth2TokenStorage()
    
    weak var delegate: AuthViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard let webViewVC = segue.destination as? WebViewViewController else { return }
            webViewVC.delegate = self
        }
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        vc.dismiss(animated: true)
        
        oauth2Service.fetchOAuthToken(code: code) { result in
            switch result {
            case .success(let token):
                self.tokenStorage.token = token
                print("Successfully fetched token: \(token)")
            case .failure(let error):
                print("Failed to fetch token: \(error)")
            }
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
}

protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate(_ vc: AuthViewController)
}




