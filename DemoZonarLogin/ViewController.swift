//
//  ViewController.swift
//  DemoZonarLogin
//
//  Created by gcshcm on 19/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextFields

class ViewController: UIViewController {
    var isHidePassword = true
    var toggleShowButton: UIButton!
    var emailTextField: MDCTextField!
    var passwordTextField: MDCTextField!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = UIColor(hexString: "#FF21272C")
        
        // Do any additional setup after loading the view.
        emailTextField = MDCTextField(frame: CGRect(x: 57, y: 250, width: 300, height: 40))
        emailTextField.textColor = UIColor.white
        view.addSubview(emailTextField)
        emailTextField.placeholderLabel.textColor = .white
        emailTextField.placeholderLabel.text = "Email Address"
        emailTextField.autocapitalizationType = .none
        emailTextField.delegate = self
        
        
        passwordTextField = MDCTextField(frame: CGRect(x: 57, y: 350, width: 300, height: 40))
        passwordTextField.textColor = UIColor.white
        view.addSubview(passwordTextField)
        passwordTextField.placeholderLabel.textColor = .white
        passwordTextField.placeholderLabel.text = "Password"
        passwordTextField.isSecureTextEntry = isHidePassword
        passwordTextField.delegate = self
        
        toggleShowButton = UIButton(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        toggleShowButton.setImage(UIImage(named: "visibility"), for: .normal)
        toggleShowButton.addTarget(self, action: #selector(onToggleButtonClick), for: .touchUpInside)
        passwordTextField.rightView = toggleShowButton
        passwordTextField.rightViewMode = .always
        NSLayoutConstraint.activate([ toggleShowButton.heightAnchor.constraint(equalToConstant: 20),
            toggleShowButton.widthAnchor.constraint(equalToConstant: 20)])
            
    }
    @objc func onToggleButtonClick(sender: AnyObject) {
        passwordTextField.isSecureTextEntry.toggle()
        if(passwordTextField.isSecureTextEntry){
            toggleShowButton.setImage(UIImage(named: "visibility"), for: .normal)
        }
        else{
            toggleShowButton.setImage(UIImage(named: "visibility_off"), for: .normal)
        }
    }

}
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End Editing of \(textField.placeholder)")
    }
}

extension UIColor {
    convenience init?(hexString: String?) {
        let input: String! = (hexString ?? "")
            .replacingOccurrences(of: "#", with: "")
            .uppercased()
        var alpha: CGFloat = 1.0
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        switch (input.count) {
        case 3 /* #RGB */:
            red = Self.colorComponent(from: input, start: 0, length: 1)
            green = Self.colorComponent(from: input, start: 1, length: 1)
            blue = Self.colorComponent(from: input, start: 2, length: 1)
            break
        case 4 /* #ARGB */:
            alpha = Self.colorComponent(from: input, start: 0, length: 1)
            red = Self.colorComponent(from: input, start: 1, length: 1)
            green = Self.colorComponent(from: input, start: 2, length: 1)
            blue = Self.colorComponent(from: input, start: 3, length: 1)
            break
        case 6 /* #RRGGBB */:
            red = Self.colorComponent(from: input, start: 0, length: 2)
            green = Self.colorComponent(from: input, start: 2, length: 2)
            blue = Self.colorComponent(from: input, start: 4, length: 2)
            break
        case 8 /* #AARRGGBB */:
            alpha = Self.colorComponent(from: input, start: 0, length: 2)
            red = Self.colorComponent(from: input, start: 2, length: 2)
            green = Self.colorComponent(from: input, start: 4, length: 2)
            blue = Self.colorComponent(from: input, start: 6, length: 2)
            break
        default:
            NSException.raise(NSExceptionName("Invalid color value"), format: "Color value \"%@\" is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", arguments:getVaList([hexString ?? ""]))
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func colorComponent(from string: String!, start: Int, length: Int) -> CGFloat {
        let substring = (string as NSString)
            .substring(with: NSRange(location: start, length: length))
        let fullHex = length == 2 ? substring : "\(substring)\(substring)"
        var hexComponent: UInt64 = 0
        Scanner(string: fullHex)
            .scanHexInt64(&hexComponent)
        return CGFloat(Double(hexComponent) / 255.0)
    }
}
