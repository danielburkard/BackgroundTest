//
//  AppDelegate.swift
//  BackgroundTest
//
//  Created by Daniel Burkard on 19.05.20.
//  Copyright © 2020 Daniel Burkard. All rights reserved.
//

import UIKit
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "de.b-linked.backgroundTest",
            using: nil) { (task) in
                self.handleAppRefreshTask(task: task as! BGProcessingTask)
        }
        
        return true
    }
    
    func handleAppRefreshTask(task: BGProcessingTask) {
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        BackgroundRun.logRun()
        task.setTaskCompleted(success: true)
        scheduleBackgroundFetch()
    }
    
    func scheduleBackgroundFetch() {
        let fetchTask = BGProcessingTaskRequest(identifier: "de.b-linked.backgroundTest")
        fetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 5)
        fetchTask.requiresNetworkConnectivity = true
        do {
            try BGTaskScheduler.shared.submit(fetchTask)
        } catch {
            print("Unable to submit task: \(error.localizedDescription)")
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
