//
//  ProductOneVC.swift
//  woocomence
//
//  Created by Admin on 8/21/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage
import AVKit

class ProductOneVC: UIViewController {
    @IBOutlet weak var txtProTitle: UILabel!
    @IBOutlet weak var txtProPer: UILabel!
    @IBOutlet weak var txtProOldValue: UILabel!
    @IBOutlet weak var txtProValue: UILabel!
    @IBOutlet weak var proRating: CosmosView!
    @IBOutlet weak var txtReview: UILabel!
    @IBOutlet weak var txtAnswer: UILabel!
    @IBOutlet weak var txtProDescription: UITextView!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var proid = ""
    var proasin = ""
    var proname = ""
    var proimage = ""
    var proprice = ""
    var proorprice = ""
    var prorating = ""
    var proreviews = ""
    var proanswers = ""
    var prodescription = ""
    var proebook = ""
    var promanual = ""
    var provideo = ""
    var proamazon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proRating.settings.fillMode = .precise
        
        getready()
    }
    func getready(){
        proid = Defaults.getNameAndValue(Defaults.PRODUCTID_KEY)
        proasin = Defaults.getNameAndValue(Defaults.PRODUCTASIN_KEY)
        proname = Defaults.getNameAndValue(Defaults.PRODUCTNAME_KEY)
        proimage = Defaults.getNameAndValue(Defaults.PRODUCTIMAGE_KEY)
        proprice = Defaults.getNameAndValue(Defaults.PRODUCTPRICE_KEY)
        proorprice = Defaults.getNameAndValue(Defaults.PRODUCTORPRICE_KEY)
        prorating = Defaults.getNameAndValue(Defaults.PRODUCTRATING_KEY)
        proreviews = Defaults.getNameAndValue(Defaults.PRODUCTREVIEWS_KEY)
        proanswers = Defaults.getNameAndValue(Defaults.PRODUCTANSWERS_KEY)
        prodescription = Defaults.getNameAndValue(Defaults.PRODUCTDESCRIPTION_KEY)
        proebook = Defaults.getNameAndValue(Defaults.PRODUCTEBOOK_KEY)
        provideo = Defaults.getNameAndValue(Defaults.PRODUCTVIDEO_KEY)
        proamazon = Defaults.getNameAndValue(Defaults.PRODUCTAMAZON_KEY)
        
        imgProduct.sd_setImage(with: URL(string: proimage), completed: nil)
        txtProTitle.text = proname
        txtProValue.text = proprice
        txtProOldValue.text = "$" + proorprice
        txtReview.text = proreviews
        txtAnswer.text = proanswers
        txtProDescription.text = prodescription
        proRating.rating = Double(prorating)! 
    }
    
    @IBAction func openManualBtn(_ sender: Any) {
        if let url = URL(string: "https://s3-us-west-2.amazonaws.com/oww-files-public/b/b8/LD_%26_TEC_Manual.pdf"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openVideoBtn(_ sender: Any) {
        let videoURL = URL(string: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.mp4")
        let player = AVPlayer(url: videoURL!)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    
    @IBAction func openWeb(_ sender: Any) {
        if let url = URL(string: proamazon), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
