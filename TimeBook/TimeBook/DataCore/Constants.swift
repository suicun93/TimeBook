//
//  Constants.swift
//  TimeBook
//
//  Created by Hoang Duc on 7/26/19.
//  Copyright © 2019 Hoang Duc. All rights reserved.
//
import UserNotifications
import Foundation
import CoreData

public class Config {
    public static let MeditationNumber = 6
    public static let defaults = UserDefaults.standard
    
    // Request to push local notification
    public static func requestNotification() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound])
        { (granted, error) in
            defaults.set(granted, forKey: "notification")
        }
    }
    
    // Check notification granted or not
    public static func notificationGranted() -> Bool {
        return defaults.bool(forKey: "notification")
    }
    
    public static func pushNotification(hour: Hour, contents: String) {
        if !notificationGranted() {
            requestNotification()
        }
        var dateComponents = DateComponents()
        switch hour {
        case .H1030h:
            dateComponents.hour = 10
            dateComponents.minute = 30
            break
        case .H12h:
            dateComponents.hour = 12
            dateComponents.minute = 00
            break
        case .H15h:
            dateComponents.hour = 15
            dateComponents.minute = 00
            break
        case .H17h:
            dateComponents.hour = 17
            dateComponents.minute = 00
            break
        case .H20h:
            dateComponents.hour = 20
            dateComponents.minute = 00
            break
        case .H8h:
            dateComponents.hour = 8
            dateComponents.minute = 00
            break
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Set notification's content
        let content = UNMutableNotificationContent()
        content.title = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        content.body = contents
        content.sound = .default
        content.badge = 1
        
        let request = UNNotificationRequest(
            identifier: hour.rawValue, content: content, trigger: trigger
        )
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    
}

// This for save data
extension Config {
    //    // Init list of meditation
    //    public static func loadListChamNgon() -> [String] {
    //        if isTheFirstTime() {
    //            // Init list cham ngon
    //            var listChamNgon:[String] = [String]()
    //            for n in 0...9 {
    //                listChamNgon.insert(ChamNgon.allValues[n].rawValue, at: 0)
    //            }
    //            defaults.set(listChamNgon, forKey: "listChamNgon")
    //        }
    //        return defaults.object(forKey: "listChamNgon") as! [String]
    //    }
    
    public static func loadListMeditationByHour() -> [String] {
        if isTheFirstTime() {
            // Init list MeditationByHour
            var listChinh:[String] = [String]()
            for n in 0...5 {
                listChinh.append(ChamNgon.allValues[n].rawValue)
            }
            saveListMeditation(listChinh: listChinh)
        }
        var listChinh:[String] = [String]()
        listChinh = defaults.object(forKey: "listMeditationByHour") as! [String]
        return listChinh
        
    }
    
    public static func saveListMeditation(listChinh: [String]) {
        defaults.set(listChinh, forKey: "listMeditationByHour")
        for n in 0...5 {
            pushNotification(hour: Hour.allValues[n], contents: listChinh[n])
        }
    }
    
    public static func isTheFirstTime() -> Bool {
//        return true
                return !defaults.bool(forKey: "first")
    }
    
    public static func didNotFirst() {
        if isTheFirstTime() {
            defaults.set(false, forKey: "first")
        }
    }
}




public enum Hour:String {
    case H8h = "8:00"
    case H12h = "12:00"
    case H1030h = "10:30"
    case H15h = "15:00"
    case H17h = "17:00"
    case H20h = "20:00"
    public static let allValues:[Hour] = [.H8h,.H1030h,.H12h,.H15h,.H17h,.H20h]
    
}

public enum ChamNgon: String {
    case cau1 = "命を大事にする"
    case cau2 = "他人のものを尊重する"
    case cau3 = "他人の関係を尊重する"
    case cau4 = "真実を話す"
    case cau5 = "人を繋げる発言をする"
    case cau6 = "優しく話す"
    case cau7 = "意味のある発言をする"
    case cau8 = "他人の喜びを喜ぶ"
    case cau9 = "他人の問題に親身になる"
    case cau10 = "ペンをよく理解する"
    public static let allValues:[ChamNgon] = [.cau1,.cau2,.cau3,.cau4,.cau5,.cau6,.cau7,.cau8,.cau9,.cau10]
}



