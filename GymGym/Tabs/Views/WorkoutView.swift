//
//  WorkoutView.swift
//  GymGym
//
//  Created by 김보윤 on 8/20/24.
//

import SwiftUI

struct WorkoutView: View {
    @State private var timeElapsed: Int = 0
    @State private var timerIsRunning = false
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            // 운동 시간 표시 (시간:분:초 형식)
            Text(formatTime(seconds: timeElapsed))
                .font(.system(size: 48, weight: .semibold, design: .default))
                .padding()
            
            // 시작/정지 버튼
            HStack(spacing: 40) {
                Button(action: {
                    timerIsRunning.toggle()
                }) {
                    Text(timerIsRunning ? "정지" : "시작")
                        .font(.title)
                        .frame(width: 80, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // 초기화 버튼
                Button(action: {
                    timeElapsed = 0
                    timerIsRunning = false
                }) {
                    Text(timerIsRunning ? "운동종료" : "")
                        .font(.title)
                        .frame(width: 80, height: 40)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 20)
            
            Spacer()  // 아래쪽에 나머지 콘텐츠를 배치할 공간 확보
        }
        .onReceive(timer) { _ in
            if timerIsRunning {
                timeElapsed += 1
            }
        }
    }
    
    // 시간을 포맷하는 함수 (시간:분:초 형식)
    func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}




#Preview {
    WorkoutView()
}
