//
//  TabbarViewController.swift
//  SOT-iOS
//
//  Created by 이숭인 on 2021/11/27.
//

import UIKit
import SnapKit
import Then

class TabbarViewController: UITabBarController {
    //MARK: - UI Components
    lazy var homeVC = HomeViewController().then{
        $0.tabBarItem = UITabBarItem(title: "피드",
                                     image: UIImage(named: "feed_off"),
                                     selectedImage: UIImage(named: "feed_on")?.withRenderingMode(.alwaysOriginal))
        $0.tabBarItem.imageInsets = UIEdgeInsets(top: 11, left: 0, bottom: -11, right: 0)
        $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 11)
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    
    lazy var searchVC = UploadVideoSecondViewController().then{
        $0.tabBarItem = UITabBarItem(title: "검색",
                                     image: UIImage(named: "search_off"),
                                     selectedImage: UIImage(named: "search_on")?.withRenderingMode(.alwaysOriginal))
        $0.tabBarItem.imageInsets = UIEdgeInsets(top: 11, left: 0, bottom: -11, right: 0)
        $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 11)
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    
    lazy var uploadVC = UploadVideoSecondViewController().then{
        $0.tabBarItem = UITabBarItem(title: "",
                                     image: UIImage(named: "upload"),
                                     selectedImage: UIImage(named: "upload")?.withRenderingMode(.alwaysOriginal))
        $0.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    
    lazy var accompanyVC = UploadVideoSecondViewController().then{
        $0.tabBarItem = UITabBarItem(title: "동행",
                                     image: UIImage(named: "list_off"),
                                     selectedImage: UIImage(named: "list_on")?.withRenderingMode(.alwaysOriginal))
        $0.tabBarItem.imageInsets = UIEdgeInsets(top: 11, left: 0, bottom: -11, right: 0)
        $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 11)
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    
    lazy var profileVC = UploadVideoSecondViewController().then{
        $0.tabBarItem = UITabBarItem(title: "프로필",
                                     image: UIImage(named: "profile_off"),
                                     selectedImage: UIImage(named: "profile_on")?.withRenderingMode(.alwaysOriginal))
        $0.tabBarItem.imageInsets = UIEdgeInsets(top: 11, left: 0, bottom: -11, right: 0)
        $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 11)
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setTabbarUI()
        setTabBarLink()
    }
    
    private func setTabbarUI(){
        tabBar.isTranslucent = true
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = .black
        tabBar.unselectedItemTintColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage() // tabbar shadow 지우기
        //        tabBar.barStyle = .black
    }
    
    private func setTabBarLink() {
        let homeVC = homeVC
        let searchVC = UINavigationController(rootViewController: searchVC)
        let uploadVC = UINavigationController(rootViewController: uploadVC)
        let accompanyVC = UINavigationController(rootViewController: accompanyVC)
        let profileVC = UINavigationController(rootViewController: profileVC)
        viewControllers = [homeVC,
                           searchVC,
                           uploadVC,
                           accompanyVC,
                           profileVC]
    }
}
