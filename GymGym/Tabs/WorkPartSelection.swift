//
//  WorkPartSelection.swift
//  GymGym
//
//  Created by 김보윤 on 8/21/24.
//

import SwiftUI

struct WorkPartSelection: View {
    @Binding var selectedAreas: [String]
    
    static let exerciseAreas: [String: Color] = [
        "Chest": (.red),
        "Shoulders": (.blue),
        "Back": (.green),
        "Core": (.orange),
        "Arms": (.purple),
        "Lower Body": (.teal),
        "Glutes": (.yellow),
        "Full Body": (.indigo),
        "Cardio": (.brown)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Muscle Groups").font(.headline)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70, maximum: 100))], spacing: 10) {
                ForEach(WorkPartSelection.exerciseAreas.keys.sorted(), id: \.self) { area in
                    Button(action: {
                        toggleSelection(for: area)
                    }) {
                        Text(area)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .frame(width: 80, height: 30)
                            .background(selectedAreas.contains(area) ? WorkPartSelection.exerciseAreas[area] : .gray)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
        
    
    func toggleSelection(for area: String) {
           if let index = selectedAreas.firstIndex(of: area) {
               // Remove the area if it's already selected
               selectedAreas.remove(at: index)
           } else {
               // Add the area if it's not already selected
               selectedAreas.append(area)
           }
       }
}

struct WorkPartSelection_Previews: PreviewProvider {
    @State static var selectedAreas = [String]()
    
    static var previews: some View {
        WorkPartSelection(selectedAreas: $selectedAreas)
    }
}
