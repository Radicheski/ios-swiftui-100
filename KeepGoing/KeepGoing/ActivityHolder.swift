//
//  ActivityHolder.swift
//  KeepGoing
//
//  Created by Erik Radicheski da Silva on 11/10/22.
//

import Foundation

class ActivityHolder: ObservableObject {
    
    static var key: String { String(describing: Self.self) }
    
    @Published var activities: [Activity] {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(activities) {
                let defaults = UserDefaults.standard
                defaults.set(data, forKey: Self.key)
            }
        }
    }
    
    init() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        if let data = defaults.data(forKey: Self.key),
           let array = try? decoder.decode([Activity].self, from: data) {
            activities = array
        } else {
            activities = []
        }
    }
    
    func addNew(_ activity: Activity) {
        activities.append(activity)
    }
    
    func incrementCounter(for activity: Activity) {
        if let index = activities.firstIndex(where: { $0.id == activity.id }) {
            activities[index].counter += 1
        }
    }
    
    func changeTitle(for id: UUID, to title: String) {
        if let index = activities.firstIndex(where: { $0.id == id }) {
            activities[index].title = title
        }
    }
}
