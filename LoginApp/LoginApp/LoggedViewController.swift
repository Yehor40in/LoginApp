//
//  LoggedViewController.swift
//  LoginApp
//
//  Created by Yehor Sorokin on 21.01.2021.
//

import UIKit

class LoggedViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var myTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        greetings(to: Auth.user!)
    }
    
    private func setupTabBar() -> Void {
        let first = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let second = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let third = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        myTabBar.setItems([first, second, third], animated: false)
    }
    
    private func greetings(to user: User) -> Void {
        welcomeLabel.text = "Welcome, \(user.firstName)!"
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        Auth.shared.deauthenticate()
        performSegue(withIdentifier: "LogoutSegue", sender: self)
    }
    
}
