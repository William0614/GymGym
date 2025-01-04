//
//  NavigationView.swift
//  GymGym
//
//  Created by 김보윤 on 8/20/24.
//

import SwiftUI

NavigationView {
    List(workouts, id: \.name) { workout in
        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
            Text(workout.name)
        }
    }
    .navigationTitle("오늘의 운동")
}
