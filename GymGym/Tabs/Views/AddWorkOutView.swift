//
//  AddWorkOutView.swift
//  GymGym
//
//  Created by 김보윤 on 8/21/24.
//
import SwiftUI

struct AddWorkoutView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Binding var workoutToEdit: Workout? // 수정할 운동
    
    @State private var workoutName: String = ""
    @State private var selectedArea: String? = nil //하나만 선택할 수 있도록 변경
    @State private var selectedOption: String = "Weight, Count"
    @State private var sameOrNot: String = "All Sets Equal"
    @State private var setCount: Int = 4
    @State private var weightUnit: String = "kg"
    @State private var timeUnit: String = "sec"
    @State private var color: Color = .blue
    @State private var alertType: AlertType? = nil
    
    @State private var weight: [String] = Array(repeating: "", count: 20) //무게
    @State private var count: [Int] = Array(repeating: 10, count: 20) //세트 별 횟수
    @State private var setTime: [Int] = Array(repeating: 0, count: 20) //시간
    
    let options = ["Weight, Count", "Count", "Time"]
    let option2 = ["All sets equal", "Each set different"]
    let weightUnits = ["kg", "lbs"]
    let timeUnits = ["sec", "min", "hour"]
    let exerciseAreas = ["Chest", "Back", "Core", "Shoulders", "Glutes", "Cardio", "Full Body", "Arms", "Lower Body"]
    
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
        ScrollView {
            VStack {
                VStack(alignment: .leading)
                {
                    workoutNameInputField()
                    areaPicker() //운동 부위 한개 선택
                }
                optionPickers()
                
                switch (selectedOption, sameOrNot) {
                case ("Weight, Count", "All sets equal"):
                    weightAndCountSameForAllSets()
                case ("Weight, Count", "Each set different"):
                    weightAndCountDifferentForEachSet()
                case ("Count", "All sets equal"):
                    countOnlySameForAllSets()
                case ("Count", "Each set different"):
                    countOnlyDifferentForEachSet()
                case ("Time", "All sets equal"):
                    timeSameForAllSets()
                case ("Time", "Each set different"):
                    timeDifferentForEachSet()
                default:
                    EmptyView()
                }
                
                Spacer()
                
                saveButton()
                    .onAppear {
                        loadWorkoutData()
                    }
            }
            .padding(.top, 20)
            .alert(item: $alertType) { type in
                switch type {
                case .error:
                    return Alert(
                        title: Text("Invalid Input"),
                        message: Text(errorMessage()),
                        dismissButton: .default(Text("Confirm"))
                    )
                case .success:
                    return Alert(
                        title: Text("Exercise Added"),
                        message: Text("Exercise has been added successfully."),
                        dismissButton: .default(Text("Confirm")) {
                            // 성공적인 저장 후 AddRoutineView로 이동
                            // 현재 뷰 닫기
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    )
                }
            }
            .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        }
    }
    
    private func loadWorkoutData() {
            if let workout = workoutToEdit {
                workoutName = workout.name
                selectedArea = workout.selectedArea
                selectedOption = workout.selectedOption
                sameOrNot = workout.sameOrNot
                setCount = workout.setCount
                weight = workout.weight
                weightUnit = workout.weightUnit
                count = workout.count
                setTime = workout.setTime
                timeUnit = workout.timeUnit
                color = workout.color
            } else {
                resetFields()
            }
        }
    
    func workoutNameInputField() -> some View {
        VStack(alignment: .leading) {
            Text("Exercise Name")
                .font(.headline)
                .padding(.leading, 20)
            
            TextField("Input exercise ex) Bench Press", text: $workoutName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal, .bottom], 20)
        }
    }
    
    func areaPicker() -> some View {
        VStack(alignment: .leading) {
            Text("Muscle Groups")
                .font(.headline)
                .padding(.leading, 20)
            
            Picker("Select Muscle Groups", selection: $selectedArea) {
                Text("Select").tag(String?.none)
                ForEach(exerciseAreas, id: \.self) { area in
                    Text(area).tag(String?.some(area))
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding([.horizontal, .bottom], 20)
        }
    }
    
    func optionPickers() -> some View {
        VStack {
            Picker("Select Option", selection: $selectedOption) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 20)
            
            Picker("Select", selection: $sameOrNot) {
                ForEach(option2, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
    }
    
    func saveButton() -> some View {
        Button(action: saveWorkout) {
            Text("Save")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding([.horizontal, .bottom], 20)
        }
    }
    
    // MARK: - Option-Specific Views
    
    func weightAndCountSameForAllSets() -> some View {
        VStack {
            HStack {
                setCountPicker()
                Spacer().frame(width: 20)
                weightUnitPicker()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                CustomTextField(text: $weight[0], placeholder: "weight")
                    .keyboardType(.decimalPad)
                    .frame(width: 100, height: 20)
                Text(weightUnit)
                countPicker(selection: $count[0])
                Text("reps")
            }
            .padding(.horizontal, 20)
        }
    }
    
    func weightAndCountDifferentForEachSet() -> some View {
        VStack {
            HStack {
                setCountPicker()
                Spacer().frame(width: 20)
                weightUnitPicker()
            }
            
            ForEach(0..<setCount, id: \.self) { index in
                HStack {
                    Text("set \(index + 1):").padding(.trailing, 20)
                    CustomTextField(text: $weight[index], placeholder: "weight")
                        .keyboardType(.decimalPad)
                        .frame(width: 100, height: 20)
                    Text(weightUnit)
                    countPicker(selection: $count[index])
                    Text("reps")
                }
            }
        }
    }
    
    func countOnlySameForAllSets() -> some View {
        VStack {
            HStack {
                setCountPicker()
                Spacer().frame(width: 20)
                countPicker(selection: $count[0])
            }
        }
    }
    
    func countOnlyDifferentForEachSet() -> some View {
        VStack {
            setCountPicker()
            
            ForEach(0..<setCount, id: \.self) { index in
                HStack {
                    Text("set \(index + 1):").padding(.trailing, 20)
                    countPicker(selection: $count[index])
                }
            }
        }
    }
    
    func timeSameForAllSets() -> some View {
        VStack {
            setCountPicker()
            HStack {
                timePicker(selection: $setTime[0])
                timeUnitPicker(selection: $timeUnit)
            }
        }
    }
    
    func timeDifferentForEachSet() -> some View {
        VStack {
            setCountPicker()
            
            ForEach(0..<setCount, id: \.self) { index in
                HStack {
                    Text("set \(index + 1):").padding(.trailing, 20)
                    timePicker(selection: $setTime[index])
                    timeUnitPicker(selection: $timeUnit)
                }
            }
        }
    }
    
    // MARK: - Picker Components
    
    func setCountPicker() -> some View {
        Picker("Set count", selection: $setCount) {
            ForEach(1..<21) { count in
                Text("\(count) sets").tag(count)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 140, height: 100)
        .clipped()
    }
    
    func weightUnitPicker() -> some View {
        Picker("Weight Unit", selection: $weightUnit) {
            ForEach(weightUnits, id: \.self) { unit in
                Text(unit).tag(unit)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 140, height: 100)
        .clipped()
    }
    
    func countPicker(selection: Binding<Int>) -> some View {
        Picker("Count", selection: selection) {
            ForEach(1..<101) { count in
                Text("\(count)").tag(count)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 140, height: 90)
        .clipped()
    }
    
    func timePicker(selection: Binding<Int>) -> some View {
        Picker("Time", selection: selection) {
            ForEach(1..<181) { time in
                Text("\(time)").tag(time)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 140, height: 90)
        .clipped()
    }
    
    func timeUnitPicker(selection: Binding<String>) -> some View {
        Picker("Time Unit", selection: selection) {
            ForEach(timeUnits, id: \.self) { unit in
                Text(unit).tag(unit)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 140, height: 60)
        .clipped()
    }
    
    // MARK: - Save Logic
    
    func saveWorkout() {
        // 운동 이름이 비어있으면 에러
        guard !workoutName.isEmpty else {
            alertType = .error
            return
        }
        
        // 운동 부위가 선택되지 않았으면 에러
        guard let selectedArea = selectedArea else {
            alertType = .error
            return
        }
        
        // '무게, 개수' 옵션이 선택된 경우 무게 입력 확인
        if selectedOption == "Weight, Count" {
            if sameOrNot == "All sets equal" {
                // 전체 세트 동일일 경우 첫 번째 무게 확인
                if weight[0].isEmpty {
                    alertType = .error
                    return
                }
            } else if sameOrNot == "Each set different" {
                // 세트마다 다른 경우 첫 setCount 개수의 무게 확인
                let weightsToCheck = Array(weight.prefix(setCount))
                let allWeightsEntered = weightsToCheck.allSatisfy { !$0.isEmpty }
                if !allWeightsEntered {
                    alertType = .error
                    return
                }
            }
        }
        
        // 새로운 운동 객체 생성
        let newWorkout = Workout(
            name: workoutName,
            selectedArea: selectedArea,
            selectedOption: selectedOption,
            sameOrNot: sameOrNot,
            setCount: setCount,
            weight: Array(weight.prefix(setCount)), // 무게 배열을 세트 수만큼 자름
            weightUnit: weightUnit,
            count: Array(count.prefix(setCount)),   // 개수 배열을 세트 수만큼 자름
            setTime: Array(setTime.prefix(setCount)), // 시간 배열을 세트 수만큼 자름
            timeUnit: timeUnit,
            color: color
        )
        
        if let index = $workoutManager.workouts.firstIndex(where: { $0.id == workoutToEdit?.id }) {
                   // 수정하는 경우 기존 운동을 교체
            workoutManager.workouts[index] = newWorkout
               } else {
                   // 새 운동을 추가
                   workoutManager.workouts.append(newWorkout)
               }
        
        // 필드 초기화
        resetFields()
        
        // 성공 알림
        alertType = .success
    }
    
    func errorMessage() -> String {
        // Logic to return error message
        if workoutName.isEmpty {
            return "Please enter the workout name."
        }
        if selectedArea == nil {
            return "Please select the exercise area."
        }
        if selectedOption == "Weight, Reps" && weight[0].isEmpty {
            return "Please enter the weight."
        }
        return "Please fill in all the information."
    }
    
    func resetFields() {
        // 필드 초기화 로직
        workoutName = ""
        selectedArea = nil
        selectedOption = "Weight, Count"
        sameOrNot = "All sets equal"
        setCount = 4
        weightUnit = "kg"
        timeUnit = "sec"
        
        // weight, count, setTime 배열을 초기 세트 수에 맞게 초기화
        weight = Array(repeating: "", count: 20)
        count = Array(repeating: 10, count: 20)
        setTime = Array(repeating: 10, count: 20)
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    @State static private var mockWorkoutToEdit: Workout? = Workout(
        name: "Pushups",
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
    
    static var previews: some View {
        AddWorkoutView(workoutToEdit: $mockWorkoutToEdit)
            .environmentObject(WorkoutManager())
    }
}


