//
//  ViewController.swift
//  Discharge
//
//  Created by David Marcus on 8/16/17.
//  Copyright © 2017 MD Now. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet var toolBar: UIToolbar!
    var forwardBtn: UIButton?
    var backBtn: UIButton?
    var homeBtn: UIButton!
    var dischargeBtn: UIButton!
    let url = URL(string:"https://home.mdnow.work/discharge")
    var webView: WKWebView!
    var credential: URLCredential?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: CGRect( x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height - 70 ), configuration: WKWebViewConfiguration() )
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        let req = URLRequest(url:url!)
        webView.load(req)
        self.webView.allowsBackForwardNavigationGestures = true
        loadingSpinner.activityIndicatorViewStyle = .whiteLarge
        loadingSpinner.color = .gray
        self.view.addSubview(loadingSpinner)
        loadingSpinner.hidesWhenStopped = true
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        )
        homeBtn = UIButton(type: .system)
        homeBtn.setImage(UIImage(named: "home"), for: .normal)
        homeBtn.setTitle("Home", for: .normal)
        homeBtn.addTarget(self, action: #selector(pressHome), for: .touchDown)
        homeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        homeBtn.sizeToFit()
        homeBtn.alignVertical()
        let homeItem = UIBarButtonItem(customView: homeBtn)
        items.append(
            homeItem
        )
        dischargeBtn = UIButton(type: .system)
        dischargeBtn.setImage(UIImage(named: "discharge"), for: .normal)
        dischargeBtn.setTitle("Discharge", for: .normal)
        dischargeBtn.addTarget(self, action: #selector(pressDischarge), for: .touchDown)
        dischargeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        dischargeBtn.sizeToFit()
        dischargeBtn.alignVertical()
        let dischargeItem = UIBarButtonItem(customView: dischargeBtn)
        items.append(
            dischargeItem
        )
        let refreshBtn = UIButton(type: .system)
        refreshBtn.setImage(UIImage(named: "refresh"), for: .normal)
        refreshBtn.setTitle("Refresh", for: .normal)
        refreshBtn.addTarget(self, action: #selector(pressRefresh), for: .touchDown)
        refreshBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        refreshBtn.sizeToFit()
        refreshBtn.alignVertical()
        let refreshItem = UIBarButtonItem(customView: refreshBtn)
        items.append(
            refreshItem
        )
        backBtn = UIButton(type: .system)
        backBtn?.setImage(UIImage(named: "back"), for: .normal)
        backBtn?.setTitle("Back", for: .normal)
        backBtn?.addTarget(self, action: #selector(pressBack), for: .touchDown)
        backBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        backBtn?.sizeToFit()
        backBtn?.alignVertical()
        let backItem = UIBarButtonItem(customView: backBtn!)
        backBtn?.isEnabled = false
        backBtn?.isUserInteractionEnabled = false
        items.append(
            backItem
        )
        forwardBtn = UIButton(type: .system)
        forwardBtn?.setImage(UIImage(named: "forward"), for: .normal)
        forwardBtn?.setTitle("Forward", for: .normal)
        forwardBtn?.addTarget(self, action: #selector(pressForward), for: .touchDown)
        forwardBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        forwardBtn?.sizeToFit()
        forwardBtn?.alignVertical()
        let forwardItem = UIBarButtonItem(customView: forwardBtn!)
        forwardBtn?.isEnabled = false
        forwardBtn?.isUserInteractionEnabled = false
        items.append(
            forwardItem
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        )
        self.toolBar.items = items
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        loadingSpinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        homeBtn.setImage(UIImage(named: "home"), for: .normal)
        dischargeBtn.setImage(UIImage(named: "discharge"), for: .normal)
        if let loadedURL = webView.url?.relativePath {
            if(loadedURL == "/") {
                homeBtn.setImage(UIImage(named: "home-filled"), for: .normal)
            } else if(loadedURL == "/discharge") {
                dischargeBtn.setImage(UIImage(named: "discharge-filled"), for: .normal)
            }
        }
        loadingSpinner.stopAnimating()
        if(!webView.canGoBack) {
            backBtn?.isEnabled = false
            backBtn?.isUserInteractionEnabled = false
        } else {
            backBtn?.isEnabled = true
            backBtn?.isUserInteractionEnabled = true
        }
        if(!webView.canGoForward) {
            forwardBtn?.isEnabled = false
            forwardBtn?.isUserInteractionEnabled = false
        } else {
            forwardBtn?.isEnabled = true
            forwardBtn?.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func pressHome() {
        let home_url = URL(string:"https://home.mdnow.work")
        let req = URLRequest(url:home_url!)
        webView.load(req)
    }
    
    @IBAction func pressDischarge() {
        let discharge_url = URL(string:"https://home.mdnow.work/discharge")
        let req = URLRequest(url:discharge_url!)
        webView.load(req)
    }
    
    @IBAction func pressRefresh() {
        webView.reload()
    }

    @IBAction func pressBack() {
        if (webView.canGoBack) {
            webView.goBack();
        }
    }
    
    @IBAction func pressForward() {
        if (webView.canGoForward) {
            webView.goForward();
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
        if(challenge.protectionSpace.authenticationMethod == "NSURLAuthenticationMethodNTLM") {
            if self.credential != nil {
                completionHandler(URLSession.AuthChallengeDisposition.useCredential, self.credential)
            } else {
                let alertController = UIAlertController(title: nil, message: "Log in to companyweb", preferredStyle: .alert)
                alertController.addTextField { (textField) in
                    textField.placeholder = "User Name"
                }
                alertController.addTextField { (textField) in
                    textField.placeholder = "Password"
                    textField.isSecureTextEntry = true
                }
                alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                    completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
                }))
                alertController.addAction(UIAlertAction(title: "Log In", style: .default, handler: { (action) in
                    if let user = alertController.textFields?.first?.text, let password = alertController.textFields?.last?.text {
                        self.credential = URLCredential(user:user, password:password, persistence:URLCredential.Persistence.none)
                        completionHandler(URLSession.AuthChallengeDisposition.useCredential, self.credential)
                    } else {
                        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
                    }
                }))
                present(alertController, animated: true, completion: nil)
            }
        } else {
            completionHandler(URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIButton {
    func alignVertical(spacing: CGFloat = 3.0) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(attributes: [NSFontAttributeName: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
}
