//
//  MoreVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit

class MoreVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
  

    @IBOutlet weak var tableView: UITableView!
    
    
    var iconArr:[UIImage] = [
    #imageLiteral(resourceName: "Layer 2"),
    #imageLiteral(resourceName: "Path 211"),
    #imageLiteral(resourceName: "Icon feather-share-2"),
    #imageLiteral(resourceName: "layer1")
    ]
    
    var titleArr = [
    "الحسابات البنكية",
    "تواصل معنا",
    "مشاركة صديق",
    "عن التطبيق"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    
    
    @IBAction func whatsapp_btn(_ sender: Any) {
        self.openwhatsapp(phone: "+9660544298982")

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath) as! MoreCell
        cell.icon_iv.image = iconArr[indexPath.row]
        cell.title_lbl.text = titleArr[indexPath.row]
        return cell
      }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let Sign = storyBoard.instantiateViewController(withIdentifier: "BankVC")as! BankVC
            
            let transition = CATransition()
            transition.duration = 0.5
        //    transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            Sign.modalPresentationStyle = .overFullScreen
            self.present(Sign, animated: true, completion: nil)
        case 1:
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let Sign = storyBoard.instantiateViewController(withIdentifier: "CallUsVC")as! CallUsVC
            
            let transition = CATransition()
            transition.duration = 0.5
        //    transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            Sign.modalPresentationStyle = .overFullScreen
            self.present(Sign, animated: true, completion: nil)
        case 2:
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let Sign = storyBoard.instantiateViewController(withIdentifier: "DesignAndProgrammingVC")as! DesignAndProgrammingVC
            
            let transition = CATransition()
            transition.duration = 0.5
         //   transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            Sign.modalPresentationStyle = .overFullScreen
            self.present(Sign, animated: true, completion: nil)
        case 3:
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let Sign = storyBoard.instantiateViewController(withIdentifier: "AboutUsVC")as! AboutUsVC
            
            let transition = CATransition()
            transition.duration = 0.5
          //  transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            Sign.modalPresentationStyle = .overFullScreen
            self.present(Sign, animated: true, completion: nil)
        default:
            print("Error")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
