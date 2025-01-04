//
//  WorkoutManager.swift
//  GymGym
//
//  Created by 김보윤 on 8/23/24.
//

import Foundation

import SwiftUI


class WorkoutManager: ObservableObject {
    @Published var workouts: [Workout] = []
    
//    init() {
//        // 초기 운동을 추가합니다.
//        let workout1 = Workout(
//            name: "벤치프레스", // 운동 이름
//            selectedArea: "가슴", // 선택한 부위
//            selectedOption: "무게, 개수", // 옵션 선택
//            sameOrNot: "전체 세트 동일", // 전체 세트 동일 여부
//            setCount: 4, // 세트 수
//            weight: ["10"], // 무게
//            weightUnit: "kg", // 무게 단위
//            count: [10], // 반복 횟수
//            setTime: [], // 시간 기반 운동이 아니므로 비어있음
//            timeUnit: "초", // 시간 단위 (시간 기반 운동이 아니므로 사용하지 않음)
//            color: WorkPartSelection.exerciseAreas["가슴"] ?? .blue // 기본값을 블루로 설정
//        )
//        
//        let workout2 = Workout(
//            name: "스쿼트",
//            selectedArea: "하체",
//            selectedOption: "무게, 개수",
//            sameOrNot: "전체 세트 동일",
//            setCount: 4,
//            weight: ["60"],
//            weightUnit: "kg",
//            count: [12],
//            setTime: [],
//            timeUnit: "초",
//            color: WorkPartSelection.exerciseAreas["하체"] ?? .green
//        )
//        
//        let workout3 = Workout(
//            name: "데드리프트",
//            selectedArea: "등",
//            selectedOption: "무게, 개수",
//            sameOrNot: "전체 세트 동일",
//            setCount: 3,
//            weight: ["80"],
//            weightUnit: "kg",
//            count: [8],
//            setTime: [],
//            timeUnit: "초",
//            color: WorkPartSelection.exerciseAreas["등"] ?? .red
//        )
//        
//        let workout4 = Workout(
//            name: "푸쉬업",
//            selectedArea: "가슴",
//            selectedOption: "개수",
//            sameOrNot: "전체 세트 동일",
//            setCount: 5,
//            weight: [],
//            weightUnit: "",
//            count: [20],
//            setTime: [],
//            timeUnit: "초",
//            color: WorkPartSelection.exerciseAreas["가슴"] ?? .blue
//        )
//        
//        let workout5 = Workout(
//            name: "플랭크",
//            selectedArea: "복근",
//            selectedOption: "시간",
//            sameOrNot: "전체 세트 동일",
//            setCount: 3,
//            weight: [],
//            weightUnit: "",
//            count: [],
//            setTime: [60],
//            timeUnit: "초",
//            color: WorkPartSelection.exerciseAreas["복근"] ?? .yellow
//        )
//        
//        let workout6 = Workout(
//            name: "플랭크",
//            selectedArea: "복근",
//            selectedOption: "시간",
//            sameOrNot: "전체 세트 동일",
//            setCount: 3,
//            weight: [],
//            weightUnit: "",
//            count: [],
//            setTime: [60],
//            timeUnit: "초",
//            color: WorkPartSelection.exerciseAreas["복근"] ?? .yellow
//        )
//        
//        let workout7 = Workout(
//            name: "플랭크",
//            selectedArea: "복근",
//            selectedOption: "시간",
//            sameOrNot: "전체 세트 동일",
//            setCount: 3,
//            weight: [],
//            weightUnit: "",
//            count: [],
//            setTime: [60],
//            timeUnit: "초",
//            color: WorkPartSelection.exerciseAreas["복근"] ?? .yellow
//        )
//
//
//
//        // workouts 배열에 초기 운동을 추가합니다.
//        workouts.append(contentsOf: [workout1, workout2, workout3, workout4, workout5, workout6, workout7])
//    }
}
