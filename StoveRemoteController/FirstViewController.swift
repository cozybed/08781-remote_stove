//
//  FirstViewController.swift
//  StoveRemoteController
//
//  Created by zhexi liu on 2/28/18.
//  Copyright © 2018 zhexi liu. All rights reserved.
//

import UIKit
import LocalAuthentication


class FirstViewController: UIViewController {

    @IBOutlet weak var stoveImg: UIImageView!
    
    @IBOutlet var progressView: UIView!
    
    var direction = "clockwise"
    var location:CGPoint = CGPoint()
    var last_position = CGPoint()
    var rotation : CGFloat = 0
    var center = CGPoint()
    var progress: UIProgressView? = nil
    var progressList = [UIProgressView?]()
    var deg: Float = 0.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        self.last_position = touch.location(in: self.view)
        
    }
    func rotate() -> Float{
        stoveImg.transform = CGAffineTransform(rotationAngle: self.rotation)
        return Float(self.rotation) * (180/Float.pi)
    }
    func get_rad(point: CGPoint) ->CGFloat  {
        if point.x == 0{
            if point.y > self.stoveImg.center.y{
                return 0
            }
            else{
                return CGFloat(Float.pi)
            }
        }
        let dif_x = point.x - self.center.x
        let dif_y = point.y - self.center.y
        if point.x > self.stoveImg.center.x{
            return atan(dif_y/dif_x)
            
        }
        return atan(dif_y/dif_x) + CGFloat(Float.pi)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        
        let rad1 = get_rad(point: self.last_position)
        print("rotation\(rad1)")
        print("touch location\(location)")
        let rad2 = get_rad(point: location)
        self.rotation += (rad2 - rad1)
        self.last_position = location
        deg = rotate()
       
        print (deg)
    }
 
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dataRequestByAngle(param: String(deg), turnAngleTo : "turnAngleTo")

    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        authenticationWithTouchID()
        stoveImg.isUserInteractionEnabled = true
        self.center = stoveImg.center
        print(center)
        
        
//        let button = UIButton()
////        button.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: 50)
//        button.frame = CGRect(x: self.center.x, y: self.center.x, width: 12, height: 22)
//        button.backgroundColor = UIColor.red
//        button.setTitle("Name your Button ", for: .normal)
//        self.view.addSubview(button)
//        progressView.transform.scaledBy(x: 1, y: 20)
//        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        
        
        
        
        let step1  = RecipeItem.StepItem(level:1,timeInSeconds:10)
        let step2  = RecipeItem.StepItem(level:3,timeInSeconds:20)
        var stepList = [RecipeItem.StepItem]()
        stepList.append(step1)
        stepList.append(step2)
        for index in 0...stepList.count{
            let pp = UIProgressView(progressViewStyle: .default)
            let thisFrame = CGRect(x: 40, y: 100 + index * 100, width: Int(self.view.frame.width - 100), height: 20)
            let thisFrame2 = CGRect(x: 40, y: 100 + index * 100 - 10, width: Int(self.view.frame.width - 100), height: 20)
            pp.frame = thisFrame
            let textView = UILabel(frame: thisFrame2)
            textView.text = "step \(index)"
            textView.textAlignment = NSTextAlignment.center
            textView.numberOfLines = 0
            textView.layer.borderColor = UIColor.black.cgColor
            self.view.addSubview(pp)
            self.view.addSubview(textView)
            textView.backgroundColor = UIColor.clear
            pp.transform = CGAffineTransform(scaleX: 1, y: 20)
            pp.setProgress(0.5, animated: true)
            pp.progressTintColor = UIColor.green
            pp.trackTintColor = UIColor.blue
            self.progressList.append(pp)
        }
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FirstViewController.tickDown)), userInfo: nil, repeats: true)
        self.progress = self.progressList.first!
        
      
        
    }
    @objc func tickDown()
    {
        self.progress!.setProgress(self.progress!.progress + 0.1, animated: true)
        print("asdf")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func rotateStove(direction: String) {
//        if direction == "clockwise" {
//            rotation = rotation + 360/8
//
//        }
//        else {
//            rotation = rotation - 360/8
//
//        }
//        self.stoveImg.transform = CGAffineTransform(rotationAngle: (CGFloat((rotation * .pi) / 360.0)))
//    }
    
    
    func dataRequestByAngle(param: String, turnAngleTo : String) {
        
        let urlToRequest = "https://api.particle.io/v1/devices/33001c000347353137323334/\(turnAngleTo)?access_token=30a9c72b4fad3857cd88aeaebdc4e4ce03e8e1c3"
        
        print (urlToRequest)
        
        let url4 = URL(string: urlToRequest)!
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "arg=\(param)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****This is the data 4: \(dataString)") //JSONSerialization
        }
        task.resume()
    }
    
    
    func dataRequest(param: String, dir : String) {
        
        let urlToRequest = "https://api.particle.io/v1/devices/33001c000347353137323334/\(dir)?access_token=30a9c72b4fad3857cd88aeaebdc4e4ce03e8e1c3"
        
        print (urlToRequest)
        
        let url4 = URL(string: urlToRequest)!
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "arg=\(param)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****This is the data 4: \(String(describing: dataString))") //JSONSerialization
        }
        task.resume()
    }
    

    @IBAction func turnButtonClicked(_ sender: Any) {
                if self.direction == "clockwise" {
            dataRequest(param: "anti_clockwise", dir : "diraction")
            self.direction = "anti-clockwise"
        }
        else {
            dataRequest(param: "clockwise", dir : "diraction")
            self.direction = "clockwise"
        }
    }
}



//https://gist.github.com/santoshbotre/d4ef8b4da366e63f6cf0178e03f17749#file-viewcontroller-swift
extension FirstViewController {
    
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        
        var authError: NSError?
        let reasonString = "To turn on the stove."
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                    
                    //TODO: User authenticated successfully, take appropriate action
                    
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    
                    print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    
                    //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                }
            }
        } else {
            
            guard let error = authError else {
                return
            }
            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication."
                
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                
            case LAError.touchIDNotEnrolled.rawValue:
                message = "TouchID is not enrolled on the device"
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
}


