//
//  RoutineView.swift
//  GymGym
//
//  Created by 김보윤 on 8/20/24.
//

import SwiftUI

struct RoutineView: View {
    @Binding var routines: [Routine]
    @Binding var routineToEdit: Routine? // Routine to edit
    @Binding var showingAddRoutine: Bool // Control the Add/Edit Routine View
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State private var routineName: String = ""
    @State private var selectedAreas: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    routineToEdit = nil // Reset the routine to edit
                    showingAddRoutine = true // Show the Add Routine view
                }) {
                    Text("Add Routine")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                ScrollView {
                    RoutineListView(routines: $routines, routineToEdit: $routineToEdit, showingAddRoutine: $showingAddRoutine, workouts: $workoutManager.workouts)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .sheet(isPresented: $showingAddRoutine) {
                AddRoutineView(workouts: $workoutManager.workouts, routines: $routines, routineToEdit: $routineToEdit, showingAddRoutine: $showingAddRoutine)
                    .environmentObject(workoutManager)  // 환경 객체 전달
            }
        }
        .onAppear {
            if let routine = routineToEdit {
                loadRoutineData(routine)
            } else {
                resetFields()
            }
        }
    }
    
    private func loadRoutineData(_ routine: Routine) {
        routineName = routine.name
        selectedAreas = routine.selectedAreas
        workoutManager.workouts = routine.workouts // WorkoutManager의 workouts에 할당
    }
    
    private func resetFields() {
        routineName = ""
        selectedAreas = []
        workoutManager.workouts = [] // 리셋 시에도 WorkoutManager의 workouts를 초기화
    }
}


struct RoutineListView: View {
    @Binding var routines: [Routine]
    @Binding var routineToEdit: Routine?
    @Binding var showingAddRoutine: Bool
    @Binding var workouts: [Workout]  // WorkoutManager의 workouts와 연결

    var body: some View {
        ForEach(routines) { routine in
            ExpandableView(
                thumbnail: ThumbnailView(content: {
                    VStack {
                        HStack {
                            Text(routine.name)
                                .font(.headline)
                            Spacer()
                            Text("\(routine.workouts.count) Exercises")
                                .font(.subheadline)
                        }
                        .foregroundColor(.white)
                        HStack {
                            ForEach(0..<routine.selectedAreas.count, id: \.self) { index in
                                let routineColor = WorkPartSelection.exerciseAreas[routine.selectedAreas[index]] ?? .gray
                                Text(routine.selectedAreas[index])
                                    .font(.footnote)
                                    .frame(height: 30)
                                    .padding(.horizontal, 10)
                                    .background(routineColor)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        EditOrDeleteView(routine: routine, routines: $routines, routineToEdit: $routineToEdit, showingAddRoutine: $showingAddRoutine)
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .background(Color.secondary)
                    .cornerRadius(10)
                }),
                expanded: ExpandedView(content: {
                    VStack {
                        RoutineDetailsView(routine: routine)
                            .padding(.bottom, 10)
                        EditOrDeleteView(routine: routine, routines: $routines, routineToEdit: $routineToEdit, showingAddRoutine: $showingAddRoutine)
                        Spacer()
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .background(.gray)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                })
            )
        }
        .padding()
    }
}

struct RoutineDetailsView: View {
    let routine: Routine
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack {
                Text(routine.name)
                    .font(.headline)
                Spacer()
                Text("\(routine.workouts.count) Exercises")
                    .font(.subheadline)
            }
            .foregroundColor(.white)
            
            ForEach(routine.workouts) { workout in
                Text("\(workout.name) \(workout.setCount) Sets")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            
            HStack {
                ForEach(0..<routine.selectedAreas.count, id: \.self) { index in
                    let routineColor = WorkPartSelection.exerciseAreas[routine.selectedAreas[index]] ?? .gray
                    Text(routine.selectedAreas[index])
                        .font(.footnote)
                        .frame(height: 30)
                        .padding(.horizontal, 10)
                        .background(routineColor)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
    }
}

struct EditOrDeleteView: View {
    let routine: Routine
    @Binding var routines: [Routine]
    @Binding var routineToEdit: Routine?
    @Binding var showingAddRoutine: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                routineToEdit = routine // Set the selected routine to edit
                showingAddRoutine = true // Show the Add Routine view for editing
            }) {
                Label("Edit", systemImage: "pencil")
                    .font(.footnote)
            }
            .tint(.white)
            Spacer()
            Button(action: {
                // Start action
            }) {
                Label("Start", systemImage: "play")
                    .font(.footnote)
            }
            .tint(.white)
            Spacer()
            Button(action: {
                if let index = routines.firstIndex(where: { $0.id == routine.id }) {
                    routines.remove(at: index) // Remove the routine
                }
            }) {
                Label("Delete", systemImage: "trash")
                    .font(.footnote)
            }
            .tint(.white)
        }
        .padding(.horizontal)
    }
}

// Mock Data for Previews
struct RoutineView_Previews: PreviewProvider {
    @State static var mockRoutines: [Routine] = [
        Routine(
            name: "Morning Routine",
            selectedAreas: ["Arms", "Lower Body"],
            workouts: [
                Workout(
                    name: "Push Ups",
                    selectedArea: "Chest",
                    selectedOption: "Weight, Count",
                    sameOrNot: "All sets equal",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "sec",
                    color: .blue
                ),
                Workout(
                    name: "Push Ups",
                    selectedArea: "Chest",
                    selectedOption: "Weight, Count",
                    sameOrNot: "All sets equal",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "sec",
                    color: .blue
                )
            ]
        ),
        Routine(
            name: "Evening Routine",
            selectedAreas: ["Back"],
            workouts: [
                Workout(
                    name: "Lat Pull",
                    selectedArea: "Back",
                    selectedOption: "Weight, Count",
                    sameOrNot: "All sets equal",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "sec",
                    color: .blue
                )
                
            ]
        )
        ,
        Routine(
            name: "Evening Routine",
            selectedAreas: ["Back"],
            workouts: [
                Workout(
                    name: "Lat Pull",
                    selectedArea: "Back",
                    selectedOption: "Weight, Count",
                    sameOrNot: "All sets equal",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "sec",
                    color: .blue
                )
                
            ]
        )
        ,
        Routine(
            name: "Evening Routine",
            selectedAreas: ["Back"],
            workouts: [
                Workout(
                    name: "Lat Pull",
                    selectedArea: "Back",
                    selectedOption: "Weight, Count",
                    sameOrNot: "All sets equal",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "sec",
                    color: .blue
                )
                
            ]
        )
        ,
        Routine(
            name: "Evening Routine",
            selectedAreas: ["Back"],
            workouts: [
                Workout(
                    name: "Lat Pull",
                    selectedArea: "Back",
                    selectedOption: "Weight, Count",
                    sameOrNot: "All sets equal",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "sec",
                    color: .blue
                )
                
            ]
        )
        ,
        Routine(
            name: "Evening Routine",
            selectedAreas: ["Back"],
            workouts: [
                Workout(
                    name: "Lat Pull",
                    selectedArea: "Back",
                    selectedOption: "Weight, Count",
                    sameOrNot: "All sets equal",
                    setCount: 3,
                    weight: ["20"],
                    weightUnit: "kg",
                    count: [15],
                    setTime: [10],
                    timeUnit: "sec",
                    color: .blue
                )
                
            ]
        )
    ]
    
    @State static var routineToEdit: Routine? = nil
    @State static var showingAddRoutine: Bool = false
    
    static var previews: some View {
        RoutineView(routines: $mockRoutines, routineToEdit: $routineToEdit, showingAddRoutine: $showingAddRoutine)
            .environmentObject(WorkoutManager())
    }
}
