//
//  MockRoutine.swift
//  GymGym
//
//  Created by 김보윤 on 8/28/24.
//

import Foundation

import SwiftUI

// Define a shared MockRoutine
class MockRoutine: ObservableObject {
    @Published var mockRoutines: [Routine] = [
        Routine(
            name: "Morning Routine",
            selectedAreas: ["팔", "하체"],
            workouts: [
                Workout(
                    name: "푸시업",
                    selectedArea: "가슴",
                    selectedOption: "무게, 개수",
                    sameOrNot: "전체 세트 동일",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "초",
                    color: .blue
                ),
                Workout(
                    name: "푸시업",
                    selectedArea: "가슴",
                    selectedOption: "무게, 개수",
                    sameOrNot: "전체 세트 동일",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "초",
                    color: .blue
                )
            ]
        ),
        Routine(
            name: "Evening Routine",
            selectedAreas: ["등"],
            workouts: [
                Workout(
                    name: "푸시업",
                    selectedArea: "가슴",
                    selectedOption: "무게, 개수",
                    sameOrNot: "전체 세트 동일",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "초",
                    color: .blue
                )
            ]
        )
    ]
}

