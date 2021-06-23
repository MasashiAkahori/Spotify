//
//  AuthViewController.swift
//  Spotify
//
//  Created by 赤堀雅司 on 19/3/21.
//

import UIKit
import WebKit


class AuthViewController: UIViewController,WKNavigationDelegate {
  private let webView: WKWebView = {
    let prefs = WKWebpagePreferences()
    prefs.allowsContentJavaScript = true
    let config = WKWebViewConfiguration()
    config.defaultWebpagePreferences = prefs
    let webView = WKWebView(frame: .zero, configuration: config)
    
    return webView
  }()
  
  public var completionHandler: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Sign in"
      view.backgroundColor = .systemBackground
      webView.navigationDelegate = self
      view.addSubview(webView)
      guard let url = AuthManager.shared.signInURL else {
        return
      }
      webView.load(URLRequest(url: url))
        
    }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    webView.frame = view.bounds
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    guard let url = webView.url else {
      return
    }
    let component = URLComponents(string: url.absoluteString)
    guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else {
      return
    }
    print("Code: \(code)")
    
    AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
      DispatchQueue.main.async {
        self?.navigationController?.popToRootViewController(animated: true)
        self?.completionHandler?(success)
      }
    }
  }
  
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
