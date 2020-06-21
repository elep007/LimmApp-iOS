//
//  ContactVC.swift
//  woocomence
//
//  Created by Admin on 8/21/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Toaster
import JTMaterialSpinner
import Alamofire
class ContactVC: UIViewController {
    var spinnerView = JTMaterialSpinner()

    @IBOutlet weak var middleVC: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SendBtn(_ sender: Any) {
        if((txtName.text! != "")&&(txtEmail.text! != "")&&(txtMessage.text! != ""))
        {
            self.view.addSubview(spinnerView)
            spinnerView.frame = CGRect(x: (UIScreen.main.bounds.size.width - 50.0) / 2.0, y: (UIScreen.main.bounds.size.height-50)/2, width: 50, height: 50)
            spinnerView.circleLayer.lineWidth = 2.0
            spinnerView.circleLayer.strokeColor = UIColor.orange.cgColor
            spinnerView.beginRefreshing()
            let parameters: Parameters = ["sender": txtName.text!, "sender_email": txtEmail.text!, "message": txtMessage.text! ]
            
            Alamofire.request(Global.baseUrl + "sendmessage.php", method: .post, parameters: parameters, encoding:JSONEncoding.default).responseJSON{ response in
                print(response)
                if let value = response.value as? [String: AnyObject] {
                    print(value)
                    let status = value["status"] as! String
                    if status == "ok" {
                        self.spinnerView.endRefreshing()
                        Toast(text: "Send Message Success").show()
                        
                    }else{
                        self.spinnerView.endRefreshing()
                        Toast(text: "Unexpected error").show()
                    }
                }
                else{
                    print("aa")
                }
            }
        } else{
            Toast(text: "Please Fill the Empty Field").show()
        }
    }
    
}
