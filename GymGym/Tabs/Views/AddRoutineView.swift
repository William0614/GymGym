//
//  AddRoutineView.swift
//  GymGym
//
//  Created by 김보윤 on 8/20/24.
//

import SwiftUI

struct AddRoutineView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var routineName: String = ""
    @State private var selectedAreas: [String] = []
    @State private var isSaved = false
    @State private var workoutToEdit: Workout? = nil // 수정할 운동
    @Binding var workouts: [Workout]
    @Binding var routines: [Routine]
    @Binding var routineToEdit: Routine?
    @Binding var showingAddRoutine: Bool
    @State private var alertType: AlertType? = nil
    
    //운동 추가, 검색 로직
    @State private var showingAddWorkout = false
    @State private var showingSearchWorkout = false
    
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    
    // 저장 성공 / 실패
    enum AlertType: Identifiable {
        case error
        case success
        
        var id: Int {
            switch self {
            case .error: return 0
            case .success: return 1
            }
        }
    }

    var body: some View {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            HStack {
                                Text("Routine Name")
                                    .font(.headline)
                                    .padding(.leading, 20)
                                Spacer()
                                SaveRoutineButton(action: saveRoutine)
                                    .fontWeight(.medium)
                            }
                            RoutineNameView(routineName: $routineName)
                                .padding(.top, -10)
                            
                            WorkPartSelection(selectedAreas: $selectedAreas)
                                .padding(.top, 10)
                            
                            ActionButtons(showingAddWorkout: $showingAddWorkout, showingSearchWorkout: $showingSearchWorkout)
                            
                            WorkoutListView(
                                workouts: $workoutManager.workouts,
                                workoutToEdit: $workoutToEdit,
                                showingAddWorkout: $showingAddWorkout
                            )
                            
                            Spacer()
                        }
                        .alert(item: $alertType) { type in
                            switch type {
                            case .error:
                                return Alert(
                                    title: Text("Input Error"),
                                    message: Text(errorMessage()),
                                    dismissButton: .default(Text("Confirm"))
                                )
                            case .success:
                                return Alert(
                                    title: Text("Routine Added"),
                                    message: Text(" '\(routineName)'Routine has been added successfully."),
                                    dismissButton: .default(Text("Confirm")) {
//                                        // close view
//                                        presentationMode.wrappedValue.dismiss()
                                    }
                                )
                            }
                        }
                        .frame(minHeight: geometry.size.height)
                        .onAppear {
                            loadRoutineData()
                        }
                    }
                    .frame(width: geometry.size.width)
                }
                .sheet(isPresented: $showingAddWorkout) {
                    AddWorkoutView(workoutToEdit: $workoutToEdit)
                        .environmentObject(workoutManager)
                }
                .sheet(isPresented: $showingSearchWorkout) {
                    SearchWorkoutView(showingAddWorkout: $showingAddWorkout)
                }
            }
        }
    
    // 루틴 데이터 로드
        private func loadRoutineData() {
            if let routineToEdit = routineToEdit {
                // 수정 모드: 기존 루틴 데이터 로드
                routineName = routineToEdit.name
                selectedAreas = routineToEdit.selectedAreas
                workoutManager.workouts = routineToEdit.workouts
            } else {
                // 추가 모드: 필드 초기화
                routineName = ""
                selectedAreas = []
                workoutManager.workouts = []
            }
        }
    
        
        func saveRoutine() {
            // 이름, 부위, 운동 목록 유효성 검사
            guard !routineName.isEmpty else {
                alertType = .error
                return
            }
            
            guard !selectedAreas.isEmpty else {
                alertType = .error
                return
            }
            
            guard !workoutManager.workouts.isEmpty else {
                alertType = .error
                return
            }
            
            if let routineToEdit = routineToEdit {
                // 기존 루틴 업데이트
                if let index = routines.firstIndex(where: { $0.id == routineToEdit.id }) {
                    routines[index] = Routine(
                        name: routineName,
                        selectedAreas: selectedAreas,
                        workouts: workoutManager.workouts // WorkoutManager의 workouts 사용
                    )
                }
            } else {
                // 새 루틴 추가
                let newRoutine = Routine(
                    name: routineName,
                    selectedAreas: selectedAreas,
                    workouts: workoutManager.workouts // WorkoutManager의 workouts 사용
                )
                routines.append(newRoutine)
            }
            
            showingAddRoutine = false // 폼 닫기
            
            // 성공 알림
            alertType = .success
        }
        func errorMessage() -> String {
            // Error message
            if routineName.isEmpty {
                return "Please enter a routine name."
            }
            if selectedAreas.isEmpty {
                return "Please select the exercise areas."
            }
            if workoutManager.workouts.isEmpty {
                return "Please add a workout."
            }
            return "Please fill in all the information."
        }
    }
// MARK: - Subviews

struct RoutineNameView: View {
    @Binding var routineName: String
    
    var body: some View {
            TextField("Routine Name", text: $routineName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
    }
}

struct ActionButtons: View {
    @Binding var showingAddWorkout: Bool
    @Binding var showingSearchWorkout: Bool
    
    var body: some View {
        VStack{
            HStack {
                Text("Exercises")
                    .font(.headline)
                Spacer()
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
            HStack(spacing: 40) {
                Button(action: {
                    showingAddWorkout.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        Text("Add")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 120)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    // 운동 검색 로직 구현
                    showingSearchWorkout.toggle()
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        Text("Search")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 120)
                    .background(Color.green)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct WorkoutListView: View {
    @Binding var workouts: [Workout]
    @Binding var workoutToEdit: Workout?
    @Binding var showingAddWorkout: Bool
    
    var body: some View {
                ForEach(workouts) { workout in
                    let workoutColor = WorkPartSelection.exerciseAreas[workout.selectedArea] ?? .gray
                    
                    ExpandableView(
                        thumbnail: ThumbnailView(content: {
                            HStack {
                                Text("\(workout.name)")
                                Spacer()
                                Text("\(workout.setCount) Sets")
                            }
                            .fontWeight(.medium)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 65)
                            .background(workoutColor)
                            .foregroundColor(.white)
                        }),
                        expanded: ExpandedView(content: {
                            VStack {
                                WorkoutDetailsView(workout: workout)
                                    .padding(.bottom, 10)
                                HStack {
                                    Button(action: {
                                        //수정 액션
                                        workoutToEdit = workout
                                        showingAddWorkout.toggle()
                                    }) {
                                        Label("Edit", systemImage: "pencil")
                                            .font(.footnote)
                                    }.tint(.orange)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        //삭제 액션
                                        if let index = workouts.firstIndex(where: {$0.id == workout.id}) {
                                            workouts.remove(at: index)
                                        }
                                    }) {
                                        Label("Delete", systemImage: "trash")
                                            .font(.footnote)
                                    }.tint(.red)
                                }.padding(.horizontal, 20)
                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .background(workoutColor)
                            .foregroundColor(.white)
                        })
                    )
                }
    }
}

struct WorkoutDetailsView: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("\(workout.name)")
                    .font(.headline)
                Spacer()
                Text("\(workout.setCount) Sets")
            }.fontWeight(.medium)
            
            if workout.selectedOption == "Weight, Count" {
                WeightOrCountDetailsView(workout: workout)
            } else if workout.selectedOption == "Time" {
                TimeDetailsView(workout: workout)
            } else { // 개수 만
                CountDetailsView(workout: workout)
            }
        }
    }
}

struct WeightOrCountDetailsView: View {
    let workout: Workout
    
    var body: some View {
        if workout.sameOrNot == "All sets equal" {
            VStack {
                ForEach(1..<workout.setCount+1, id: \.self) { count in
                    Text("\(count) set: \(workout.weight[0]) \(workout.weightUnit) * \(workout.count[0]) reps")
                        .padding(.bottom, 2)
                        .font(.footnote)
                }
            }
        } else { // 세트마다 다를 경우
            VStack {
                ForEach(1..<workout.setCount+1, id: \.self) { count in
                    Text("\(count) set: \(workout.weight[count-1]) \(workout.weightUnit) * \(workout.count[count-1]) reps")
                        .padding(.bottom, 2)
                        .font(.footnote)
                }
            }
        }
    }
}

struct TimeDetailsView: View {
    let workout: Workout
    
    var body: some View {
        if workout.sameOrNot == "All sets equal" {
            VStack {
                ForEach(1..<workout.setCount+1, id: \.self) { count in
                    Text("\(count) set: \(workout.setTime[0]) \(workout.timeUnit)")
                        .padding(.bottom, 2)
                        .font(.footnote)
                }
            }
        } else { // 세트마다 다를 경우
            VStack {
                ForEach(1..<workout.setCount+1, id: \.self) { count in
                    Text("\(count) set: \(workout.setTime[count-1]) \(workout.timeUnit)")
                        .padding(.bottom, 2)
                        .font(.footnote)
                }
            }
        }
    }
}

struct CountDetailsView: View {
    let workout: Workout
    
    var body: some View {
        if workout.sameOrNot == "All sets equal" {
            VStack {
                ForEach(1..<workout.setCount+1, id: \.self) { count in
                    Text("\(count) set: \(workout.count[0]) reps")
                        .padding(.bottom, 2)
                        .font(.footnote)
                }
            }
        } else { // 세트마다 다를 경우
            VStack {
                ForEach(1..<workout.setCount+1, id: \.self) { count in
                    Text("\(count) set: \(workout.count[count-1]) reps")
                        .padding(.bottom, 2)
                        .font(.footnote)
                }
            }
        }
    }
}

struct SaveRoutineButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Save")
                .foregroundColor(.blue)
                .padding()
        }
    }
}


struct AddRoutineView_Previews: PreviewProvider {
    @State static var mockWorkouts: [Workout] = []  // Create a mock state for workouts
    @State static var mockRoutines: [Routine] = []
    @State static var routineToEdit: Routine? = nil
    @State static var showingAddRoutine: Bool = false
    
    static var previews: some View {
        AddRoutineView(workouts: $mockWorkouts, routines: $mockRoutines, routineToEdit: $routineToEdit, showingAddRoutine: $showingAddRoutine)  // Pass the binding to the view
            .environmentObject(WorkoutManager())  // Provide the environment object
    }
}
