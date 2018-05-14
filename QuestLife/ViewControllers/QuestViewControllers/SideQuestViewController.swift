//
//  SideQuestViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/12/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit

class SideQuestViewController: UIViewController {
    var user : UserModel?
    
    @IBOutlet weak var userClassLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        user = Singleton.sharedInstance.user
        let userClassString = user?.userClass
        avatarIcon.image = UIImage(named: userClassString!)
        userClassLabel.text = userClassString
        
        userNameLabel.text = user?.userName
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

}
