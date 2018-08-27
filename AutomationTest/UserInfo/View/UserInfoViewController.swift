//
//  UserInfoViewController.swift
//  TestProject
//
//  Created by Luca Schifino on 26/08/18.
//  Copyright © 2018 Luca Schifino. All rights reserved.
//

import UIKit
import Lottie

class UserInfoViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            if let user = userInfoViewModel?.user {
                let text = R.string.localizable.nameInfo() + user.name + R.string.localizable.ageInfo() + user.age + R.string.localizable.yearsOld()
                self.infoLabel.text = text
            }
        }
    }
    
    @IBOutlet weak var auxiliarView: UIView!
    
    //MARK: - Variables
    var userInfoViewModel: UserInfoViewModel?
    
    //MARK: - Lifecicle
    class func instantiate(withUser user: User) -> UserInfoViewController? {
        let viewController = R.storyboard.userInfo.userInfoViewController()
        viewController?.userInfoViewModel = UserInfoViewModel(user)
        return viewController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let animationView = LOTAnimationView(name: "simple_tick_2")
        animationView.frame = auxiliarView.frame
        self.view.addSubview(animationView)
        animationView.play()
    }
}
