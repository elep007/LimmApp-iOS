//
//  ProductVC.swift
//  woocomence
//
//  Created by Admin on 8/21/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import JTMaterialSpinner
class ProductVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var productoneVC: ProductOneVC!
    var allProduct = [Product]()
    var filterProduct = [Product]()
    var spinnerView = JTMaterialSpinner()
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
//        let rootRef = Database.database().reference()
//        let itemsRef = rootRef.child("product")
//        itemsRef.child("image").setValue("image123")
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.init(red: 40/255, green: 125/255, blue: 56/255, alpha: 1)
        
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.addSubview(spinnerView)
        spinnerView.frame = CGRect(x: (UIScreen.main.bounds.size.width - 50.0) / 2.0, y: (UIScreen.main.bounds.size.height-50)/2, width: 50, height: 50)
        spinnerView.circleLayer.lineWidth = 2.0
        spinnerView.circleLayer.strokeColor = UIColor.orange.cgColor
        spinnerView.beginRefreshing()
        
        let products_list = Database.database().reference()
        products_list.observeSingleEvent(of: .value, with: { snapshot in
            
            // SHOWING WHATEVER WAS RECEIVED FROM THE SERVER JUST AS A CONFIRMATION. FEEL FREE TO DELETE THIS LINE.
            print(snapshot)
            
            // PROCESSES VALUES RECEIVED FROM SERVER
            if ( snapshot.value is NSNull ) {
                self.spinnerView.endRefreshing()
                print("– – – Data was not found – – –")

            } else {
                for product_child in (snapshot.children) {

                    let product_snap = product_child as! DataSnapshot
                    let dict = product_snap.value as! [String: Any?]

                    // DEFINE VARIABLES FOR LABELS
                    let pro_id = dict["id"] as? Int
                    let proid = "\(pro_id!)"
                    let proasin = dict["asin"] as? String
                    let proname = dict["name"] as? String
                    let proimage = dict["image"] as? String
                    let pro_price = dict["price"] as? Double
                    let proprice = "\(pro_price!)"
                    let pro_orprice = dict["originalprice"] as? Double
                    let proorprice = "\(pro_orprice!)"
                    let pro_rating = dict["rating"] as? Double
                    let prorating = "\(pro_rating!)"
                    let pro_reviews = dict["reviews"] as? Int
                    let proreviews = "\(pro_reviews!)"
                    let pro_answers = dict["answers"] as? Int
                    let proanswers = "\(pro_answers!)"
                    let prodescription = dict["description"] as? String
                    let proebook = dict["ebook"] as? String
                    let promanual = dict["manual"] as? String
                    let provideo = dict["video"] as? String
                    let proamazon = dict["amazon"] as? String
                    let product = Product(productid: proid, productasin: proasin!, productname: proname!, productimage: proimage!, productprice: proprice, productorprice: proorprice, productrating: prorating, productreviews: proreviews, productanswers: proanswers, productdescription: prodescription!, productebook: proebook!, productmanual: promanual!, productvideo: provideo!, productamazon: proamazon!)
                    self.allProduct.append(product)
                }
                self.spinnerView.endRefreshing()
                self.tableView.dataSource = self
                self.tableView.delegate = self
            }
        })
        
    }
    
    private func filterProducts(for searchText: String) {
        filterProduct = allProduct.filter { product_filter in
            return product_filter.productname.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterProduct.count
        }
        return allProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let oneProduct: Product
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: "cell"), for: indexPath) as! ProductCell
        if searchController.isActive && searchController.searchBar.text != "" {
            oneProduct = filterProduct[indexPath.row]
        } else {
            oneProduct = allProduct[indexPath.row]
        }
        
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.borderColor = UIColor.lightGray.cgColor
        cell.cellView.layer.cornerRadius = 20
        cell.cellView.clipsToBounds = true
        cell.productImage.sd_setImage(with: URL(string: oneProduct.productimage), completed: nil)
        cell.productTitle.text = oneProduct.productname
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let oneProduct: Product
        if searchController.isActive && searchController.searchBar.text != "" {
            oneProduct = filterProduct[indexPath.row]
        } else {
            oneProduct = allProduct[indexPath.row]
        }
        searchController.isActive = false
        print(oneProduct.productid)
        print(oneProduct.productname)
        
        Defaults.save(oneProduct.productid, with: Defaults.PRODUCTID_KEY)
        Defaults.save(oneProduct.productasin, with: Defaults.PRODUCTASIN_KEY)
        Defaults.save(oneProduct.productname, with: Defaults.PRODUCTNAME_KEY)
        Defaults.save(oneProduct.productimage, with: Defaults.PRODUCTIMAGE_KEY)
        Defaults.save(oneProduct.productprice, with: Defaults.PRODUCTPRICE_KEY)
        Defaults.save(oneProduct.productorprice, with: Defaults.PRODUCTORPRICE_KEY)
        Defaults.save(oneProduct.productrating, with: Defaults.PRODUCTRATING_KEY)
        Defaults.save(oneProduct.productreviews, with: Defaults.PRODUCTREVIEWS_KEY)
        Defaults.save(oneProduct.productanswers, with: Defaults.PRODUCTANSWERS_KEY)
        Defaults.save(oneProduct.productdescription, with: Defaults.PRODUCTDESCRIPTION_KEY)
        Defaults.save(oneProduct.productebook, with: Defaults.PRODUCTEBOOK_KEY)
        Defaults.save(oneProduct.productmanual, with: Defaults.PRODUCTMANUAL_KEY)
        Defaults.save(oneProduct.productvideo, with: Defaults.PRODUCTVIDEO_KEY)
        Defaults.save(oneProduct.productamazon, with: Defaults.PRODUCTAMAZON_KEY)
        
        print(Defaults.getNameAndValue(Defaults.PRODUCTNAME_KEY))
        
        productoneVC = self.storyboard?.instantiateViewController(withIdentifier: "productoneVC") as? ProductOneVC
        self.present(productoneVC, animated: true, completion: nil)
    }
    
}
extension ProductVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       filterProducts(for: searchController.searchBar.text ?? "")
    }
}
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
