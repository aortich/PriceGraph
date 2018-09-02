//
//  ViewController.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 8/28/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.insertGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.promptTouchId()
    }
    
    /**
     Prompts the touch ID dialogue to the user
     */
    func promptTouchId() {
        let context = LAContext()
        var error: NSError?
        let reason = "Usa TouchID para entrar a la app!"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                if(success) {
                    self.moveToNextScreen()
                } else {
                    self.showAlertMessage("Autenticación fallida.")
                }
            }
        } else {
            //self.continueButton.isHidden = false
        }
        
        
    }
    
    /**
     Shows the next screen
     */
    func moveToNextScreen() {
        guard let graphController = self.storyboard?.instantiateViewController(withIdentifier: "GraphViewController") else {
            return
        }
       self.present(graphController, animated: true, completion: nil)
    }
    /**
     Prompts an alert message
     */
    func showAlertMessage(_ message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
      
    }
    /**
     Creates a cool gradient so app doesn't look as ugly
     */
    func insertGradient() {
        let color1 = UIColor(red: 43.0/255.0, green: 52.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        let color2 =  UIColor(red: 200.0/255.0, green: 211.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.view.frame.size
        gradient.locations = [0.0, 1.0]
        gradient.colors = [color1.cgColor, color2.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

