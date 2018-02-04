//
//  ViewControllerfordetails.swift
//  Ramp
//
//  Created by Abhay Sidhwani on 04/02/2018.
//  Copyright © 2017 Indefinite Integrals. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerfordetails: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var ServiceRoutes: UITextField!
    
    @IBOutlet weak var CrimeRate: UITextField!
    
    @IBOutlet weak var ServicingCost: UITextField!
    
    @IBOutlet weak var EstimatedSize: UITextField!
    
    @IBOutlet weak var CommunicationCost: UITextField!
    
    @IBOutlet weak var MarketPotential: UITextField!
    
    @IBOutlet weak var Lease: UITextField!
    
    @IBOutlet weak var NearestATMDistance: UITextField!
    
    @IBOutlet weak var OwnATM: UITextField!
    
    @IBOutlet weak var ATMinvicinity: UITextField!
    
    @IBOutlet weak var WeekDayTraffic: UITextField!
    
    @IBOutlet weak var WeekTraffic: UITextField!
    
    @IBOutlet weak var LocationPopularityIndex: UITextField!
    
    @IBOutlet weak var EstimatedTransactions: UITextField!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func SubmitDetails(_ sender: UIButton) {
        
        if (EstimatedTransactions.text != ""  && LocationPopularityIndex.text != "" && WeekTraffic.text != "" && WeekDayTraffic.text != "" && EstimatedSize.text != "" &&
            ServiceRoutes.text != "" && ATMinvicinity.text != "" && OwnATM.text != "" && NearestATMDistance.text != "" && Lease.text != "" && MarketPotential.text != "" && CommunicationCost.text != "" && CrimeRate.text != "" && ServicingCost.text != ""){
            sender.setTitle("Loading...", for: .normal)
                        let url = URL(string :"http://192.168.78.45:7700/api/v1/mobile?etpd=\(EstimatedTransactions.text!)&locpop=\(LocationPopularityIndex.text!)&weektraffic=\(WeekTraffic.text!)&weekdaytraffic=\(WeekDayTraffic.text!)&etsize=\( EstimatedSize.text!)&serviceroutes=\(ServiceRoutes.text!)&atminprox=\(ATMinvicinity.text!)&ownatm=\(OwnATM.text!)&nearatm=\(NearestATMDistance.text!)&lease=\(Lease.text!)&mpot=\(MarketPotential.text!)&comm=\(CommunicationCost.text!)&crimerate=\(CrimeRate.text!)&servicecost=\(ServicingCost.text!)")!
            
            let task = URLSession.shared.dataTask(with: url){(data,response,error) in
                if error != nil {
                    print("Error 404 Result Not Found")
                }
                else {
                    
                   
                    if let content = data {
                        
                        do{
                            sender.setTitle("Submit Details", for: .normal)
                            let myjson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            let pred = myjson["prediction"]!!
                            
                            
                            let string = "I am \(pred)% in favour of installing an ATM here "
                            let utterance = AVSpeechUtterance(string: string)
                            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                            
                            let synth = AVSpeechSynthesizer()
                            synth.speak(utterance)
                            
                            
                            
                        }
                        catch{
                            
                        }
                    }
                }
            }
            task.resume()
            
        }
        else {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupid") as! PopupViewController
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewControllerfordetails.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        let String = "Hello, I am RAMP.Please enter the details to get going "
        let utterance = AVSpeechUtterance(string: String)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
        
        // Do any additional setup after loading the view, typically from a nib.
       
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 1...9:
            textField.keyboardType = .decimalPad
            
        case 10...14 :
            ScrollView.setContentOffset(CGPoint(x : 0,y : 200), animated: true)
            textField.keyboardType = .decimalPad
        default :
            print("Do Nothing")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x : 0, y : 0), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            LocationPopularityIndex.becomeFirstResponder()
        case 2:
            WeekTraffic.becomeFirstResponder()
        case 3:
            WeekDayTraffic.becomeFirstResponder()
        case 4:
            ATMinvicinity.becomeFirstResponder()
        case 5:
            OwnATM.becomeFirstResponder()
        case 6:
            NearestATMDistance.becomeFirstResponder()
        case 7:
            Lease.becomeFirstResponder()
        case 8:
            MarketPotential.becomeFirstResponder()
        case 9:
            CommunicationCost.becomeFirstResponder()
        case 10:
            ServiceRoutes.becomeFirstResponder()
        case 11:
            CrimeRate.becomeFirstResponder()
        case 12:
            ServicingCost.becomeFirstResponder()
        case 13:
            EstimatedSize.becomeFirstResponder()
        default :
            textField.resignFirstResponder()
            
        }
        return true
    }
    
    
}
@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
