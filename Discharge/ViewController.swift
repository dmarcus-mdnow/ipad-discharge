//
//  ViewController.swift
//  Discharge
//
//  Created by David Marcus on 8/16/17.
//  Copyright © 2017 MD Now. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var webView: UIWebView!
    var forwardBtn: UIButton?
    var backBtn: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        let url = NSURL (string: "https://home.mdnow.work/discharge")
        let requestObj = NSURLRequest(url : url! as URL)
        webView.loadRequest(requestObj as URLRequest)
        loadingSpinner.hidesWhenStopped = true
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        )
        let dischargeBtn = UIButton(type: .system)
        dischargeBtn.setImage(UIImage(named: "home"), for: .normal)
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
    
    func webViewDidStartLoad(_ webView: UIWebView){
        loadingSpinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
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
    
    @IBAction func pressDischarge() {
        let url = NSURL (string: "https://home.mdnow.work/discharge");
        let requestObj = NSURLRequest(url : url! as URL);
        webView.loadRequest(requestObj as URLRequest);
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
