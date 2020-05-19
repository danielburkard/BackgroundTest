//
//  BackgroundRun.swift
//  BackgroundTest
//
//  Created by Daniel Burkard on 19.05.20.
//  Copyright © 2020 Daniel Burkard. All rights reserved.
//

import Foundation

struct BackgroundRun {
    private static let key = "backgroundRuns"
    private static var formatter: DateFormatter = {
        $0.timeStyle = .medium
        $0.dateStyle = .medium
        return $0
    }(DateFormatter())
    
    static func logRun() {
        let date = formatter.string(from: Date())
        let log: String
        if let backgroundRuns = UserDefaults.standard.string(forKey: BackgroundRun.key) {
            log = "\(backgroundRuns)\n\(date)"
        } else {
            log = date
        }
        
        UserDefaults.standard.set(log, forKey: BackgroundRun.key)
    }
    
    static func getRuns() -> [String] {
        if let backgroundRuns = UserDefaults.standard.string(forKey: BackgroundRun.key) {
            return backgroundRuns.split(separator: "\n").map { String($0) }
        } else {
            return []
        }
    }
}

@propertyWrapper struct UserDefaultsBacked<Value> {
    let key: String
    var storage: UserDefaults = .standard

    var wrappedValue: Value? {
        get { storage.value(forKey: key) as? Value }
        set { storage.setValue(newValue, forKey: key) }
    }
}
