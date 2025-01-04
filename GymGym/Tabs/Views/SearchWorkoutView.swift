//
//  SearchWorkoutView.swift
//  GymGym
//
//  Created by 김보윤 on 9/1/24.
//

import SwiftUI

struct SearchWorkoutView: View {
    @Binding var showingAddWorkout: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                showingAddWorkout.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    Text("새로운 운동 추가")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
                .frame(height: 15)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            // 운동 검색 텍스트 필드
            // 지금까지 추가 했던 운동들이 다 저장되어있는 데이터 베이스
            // 추가했던 운동은 운동 부위별로 분류.
            // 운동 부위별로 분류된 운동들에서 검색 가능.
            Spacer()
        }
    }
}

struct SearchWorkoutView_Previews: PreviewProvider {
    @State static var showingAddWorkout: Bool = false
    
    static var previews: some View {
        SearchWorkoutView(showingAddWorkout: $showingAddWorkout)
    }
}
