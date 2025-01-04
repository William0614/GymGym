//
//  ContentView.swift
//  GymGym
//
//  Created by 김보윤 on 8/20/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var workoutManager = WorkoutManager()
    @State private var routines: [Routine] = []
    @State private var routineToEdit: Routine? = nil
    @State private var showingAddRoutine: Bool = false
    
    var body: some View {
        TabView {
            WorkoutView()
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("운동")
                }
            
            RoutineView(routines: $routines, routineToEdit: $routineToEdit, showingAddRoutine: $showingAddRoutine)
                .tabItem {
                    Image(systemName: "clock")
                    Text("루틴")
                }
            
            RecordView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("기록")
                }
            
            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("더보기")
                }
        }
        .environmentObject(workoutManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

