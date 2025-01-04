//
//  RoutineManager.swift
//  GymGym
//
//  Created by 김보윤 on 8/27/24.
//

import Foundation

import SwiftUI

class RoutineManager: ObservableObject {
    @Published var routines: [Routine] = []
    
    init() {
        // Example workouts
        let exampleWorkouts = [
            Workout(
                name: "Bench Press",
                selectedArea: "Chest",
                selectedOption: "Weight, Count",
                sameOrNot: "All sets equal",
                setCount: 3,
                weight: ["50", "55", "60"],
                weightUnit: "kg",
                count: [10, 8, 6],
                setTime: [],
                timeUnit: "min",
                color: WorkPartSelection.exerciseAreas["Chest"] ?? .blue //default blue
            ),
            Workout(
                name: "Dumbell Curl",
                selectedArea: "Arms",
                selectedOption: "Weight, Count",
                sameOrNot: "Each set different",
                setCount: 3,
                weight: ["12", "14", "16"],
                weightUnit: "kg",
                count: [12, 10, 8],
                setTime: [],
                timeUnit: "sec",
                color: WorkPartSelection.exerciseAreas["Arms"] ?? .blue) // default blue
        ]
        
        // add initial routine
        let initialRoutine = Routine(
            name: "Bench Press",
            selectedAreas: ["Chest", "Arms"],
            workouts: exampleWorkouts
        )

        // add initial routine to routines array
        routines.append(initialRoutine)
    }
    
}
