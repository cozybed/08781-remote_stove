//
//  CamViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 4/17/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit
import WebKit

class CamViewController: UIViewController, NSURLConnectionDelegate {

    @IBOutlet weak var webview: WKWebView!
    

    /*
     * Hard coding url, username and password info to bypass authentication.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url_string = "http://a-eight.asuscomm.com:7021/mjpg/1/video.mjpg"
        let urlComponents = NSURLComponents(string:url_string);
        urlComponents?.user = "root";
        urlComponents?.password = "safeguardian";
        
        let url = urlComponents?.url;
        let requestObj = URLRequest(url: url!);
        webview.load(requestObj)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
