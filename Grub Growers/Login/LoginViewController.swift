//
//  LoginViewController.swift
//  Grub Growers
//
//  Created by Nadia Goodlet on 10/03/2020.
//  Copyright © 2020 Nadia Goodlet. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    static func styleTextField(_ textfield:UITextField) {
               
               // Create the bottom line
               let bottomLine = CALayer()
               
               bottomLine.frame = CGRect(x: 0, y: textfield.frame.height + 5, width: textfield.frame.width, height: 2)
               
               bottomLine.backgroundColor = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).cgColor
               
               // Remove border on text field
               textfield.borderStyle = .none
               
               // Add the line to the text field
               textfield.layer.addSublayer(bottomLine)
               
           }

    func setUpElements() {
        
        //Hide the error label
        errorLabel.alpha = 0
        
        LoginViewController.styleTextField(emailTextField)
        LoginViewController.styleTextField(passwordTextField)
        
        
        // Rounded corners on Sign Up button
        let path = UIBezierPath(roundedRect: self.loginButton.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
           let maskLayer = CAShapeLayer()
           maskLayer.frame = self.loginButton.bounds
           maskLayer.path = path.cgPath
           self.loginButton.layer.mask = maskLayer
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func loginTapped(_ sender: Any) {
    }
    
}
