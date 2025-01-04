//
//  Workout.swift
//  GymGym
//
//  Created by 김보윤 on 8/23/24.
//

import Foundation
import SwiftUI

struct Workout: Identifiable {
    let id = UUID() // 각 Workout 객체를 고유하게 식별하기 위한 고유 ID
    var name: String // 운동의 이름 (예: 벤치프레스)
    var selectedArea: String // 운동 부위 (예: 가슴, 어깨 등)
    var selectedOption: String // 운동의 종류에 따른 옵션 (예: "무게, 개수", "시간" 등)
    var sameOrNot: String // 세트마다 동일한지 여부 ("전체 세트 동일" 또는 "세트마다 다름")
    var setCount: Int // 세트 수 (예: 4세트)
    var weight: [String] // 운동 시 사용하는 무게
    var weightUnit: String // 무게의 단위 (예: "kg" 또는 "lbs")
    var count: [Int] // 반복 횟수 (예: 10회)
    var setTime: [Int] // 운동 시간을 저장 (예: 30초)
    var timeUnit: String // 시간 단위 (예: "초", "분", "시간")
    var color: Color //운동 부위 색을 나타냄
}
