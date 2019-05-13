//
//  AchieveTodayController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMobileAds
protocol TellDismissDelegate: class {
    func tellDismiss()
}
class AchieveTodayController: UIViewController, GADBannerViewDelegate {
    let achieveTodayView = AchieveTodayView.instance()
    let habitModel = HabitModel()
    weak var delegate: TellDismissDelegate?
    let AdMobID = ""
    let TestID = "ca-app-pub-3940256099942544/2934735716" // for test
    // Your TestDevice ID
    let AdMobTest = false
//    let SimulatorTest = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        achieveTodayView.frame = self.view.frame
        self.view.addSubview(achieveTodayView)
        achieveTodayView.setUpUi()
        achieveTodayView.setUpQuotation()
        achieveTodayView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        var admobView = GADBannerView()
         print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        admobView.frame = CGRect(x:((self.view.bounds.width-320)/2),y:(self.view.frame.origin.y+500),width:320,height:50)
        
        if AdMobTest {
            admobView.adUnitID  = TestID
        }
        else{
            admobView.adUnitID  = AdMobID
        }
        
        admobView.delegate = self
        admobView.rootViewController = self
        
        let admobRequest = GADRequest()
//       admobRequest.testDevices = [kGADSimulatorID]
        
//        if AdMobTest {
//            if SimulatorTest {
//                admobRequest.testDevices = [kGADSimulatorID]
//            }
//            else {
//                admobRequest.testDevices = [DEVICE_ID]
//            }
//        }
        admobView.load(admobRequest)
//        admobView.isHidden = true
     
        self.achieveTodayView.addSubview(admobView)
    
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        finishDayJudge()
        achieveTodayView.animationStart()
    }

    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
        delegate?.tellDismiss()
    }
    //習慣を終了した日にちを登録
    func finishDayJudge() {
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitModel.currentHabitNum())").first
        if habit?.currentGoalNum == 30 {
            achieveTodayView.backButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                let achieveVc = UIStoryboard(name: "Achieve", bundle: nil).instantiateViewController(withIdentifier: "Achieve") as! AchieveController
                achieveVc.modalPresentationStyle = .overFullScreen
                achieveVc.modalTransitionStyle = .crossDissolve
                achieveVc.delegate = self
                self.present(achieveVc, animated: true, completion: nil)
            }
            if habit?.finishDay == "" {
                habitModel.saveFinishDay(habitNum: habitModel.currentHabitNum())
            }
        } else {
            print("まだ習慣は終了していません")
        }
    }
    
}
extension AchieveTodayController: TellGoalPageDelegate {
    func tellDismiss() {
        delegate?.tellDismiss()
    }
}
