//
//  RevenueViewController.swift
//  Together
//
//  Created by Alek Matthiessen on 11/12/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

var yoursubscribers = String()
var yourmrr = String()
var yourtotalreve = String()

class RevenueViewController: UIViewController {
    @IBOutlet weak var mrr: UILabel!
    
    @IBOutlet weak var totalrevenue: UILabel!
    @IBOutlet weak var payingsubscribers: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        ref = Database.database().reference()

        
        queryforinfo()
        
        tapmonthly.alpha = 1
        tapsubscribers.alpha = 0.25
        taptotal.alpha = 0.25
        descriptivelabel.text = "Monthly Recurring Revenue"
        realvalue.text = "$\(yourmrr)"
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tapsubscribers: UIButton!
    
    @IBOutlet weak var realvalue: UILabel!
    @IBOutlet weak var descriptivelabel: UILabel!
    @IBOutlet weak var tapmonthly: UIButton!
    @IBAction func tapSubscribers(_ sender: Any) {
        
        tapsubscribers.alpha = 1
        tapmonthly.alpha = 0.25
        taptotal.alpha = 0.25
        descriptivelabel.text = "Paid Subscribers"
        realvalue.text = yoursubscribers
        
    }

    @IBAction func tapMonthly(_ sender: Any) {
        
        tapmonthly.alpha = 1
        tapsubscribers.alpha = 0.25
        taptotal.alpha = 0.25
        descriptivelabel.text = "Monthly Recurring Revenue"
        realvalue.text = "$\(yourmrr)"
    }
    @IBOutlet weak var taptotal: UIButton!
    @IBAction func tapTotal(_ sender: Any) {
        
        taptotal.alpha = 1
        tapmonthly.alpha = 0.25
        tapsubscribers.alpha = 0.25
        descriptivelabel.text = "Total Revenue"
        realvalue.text = "$\(yourtotalreve)"
    }
    func queryforinfo() {
        
        var functioncounter = 0
            
            ref?.child("Influencers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                if var author2 = value?["Subscribers"] as? String {
                    
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = NumberFormatter.Style.decimal
                    let formattedNumber = numberFormatter.string(from: NSNumber(value:Int(author2)!))
                    yoursubscribers = formattedNumber!
                    
                    if var author3 = value?["Price"] as? String {
                        
                        var newprice = Double(Int(author2)!) * Double(Int(author3)!)
                        
                        let numberFormatter = NumberFormatter()
                        numberFormatter.numberStyle = NumberFormatter.Style.decimal
                        let formattedNumber = numberFormatter.string(from: NSNumber(value:Int(newprice)))
                        yourmrr = formattedNumber!
                        self.realvalue.text = "$\(yourmrr)"

                    }
                    
                }
                
                if var author4 = value?["Total Revenue"] as? String {
                    
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = NumberFormatter.Style.decimal
                    let formattedNumber = numberFormatter.string(from: NSNumber(value:Int(author4)!))
                    yourtotalreve = formattedNumber!

                }
                
                if var views = value?["ProgramName"] as? String {
                    
                    selectedprogramname = views
                    self.programname.text = selectedprogramname
                } else {
                    
                    selectedprogramname = "-"
                    self.programname.text = selectedprogramname
                }
   
                if var profileUrl = value?["ProPic"] as? String {
                    // Create a storage reference from the URL
                    
                    let url = URL(string: profileUrl)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    selectedimage = UIImage(data: data!)!
                    self.propic.image = selectedimage

                } else {
                    
                    selectedimage = UIImage(named: "Placeholder")!
                    self.propic.image = selectedimage
                    
                    
                }
                
            })
            
        }
    @IBOutlet weak var propic: UIImageView!
    @IBOutlet weak var programname: UILabel!
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

