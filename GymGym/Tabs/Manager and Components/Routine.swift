//
//  Routine.swift
//  GymGym
//
//  Created by 김보윤 on 8/27/24.
//

import Foundation
import SwiftUI

struct Routine: Identifiable {
    let id = UUID() // 각 Routine 객체를 고유하게 식별하기 위한 고유 ID
    var name: String // 루틴의 이름 (예: 가슴 루틴)
    var selectedAreas: [String] // 루틴에 해당하는 운동 부위. 복수 가능 (예: 가슴, 어깨 등)
    var workouts: [Workout] //루틴을 구성하는 운동들
}


































