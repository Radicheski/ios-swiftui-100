//
//  ContentView.swift
//  KeepGoing
//
//  Created by Erik Radicheski da Silva on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var holder = ActivityHolder()
    
    @State private var isShowingEditAlert = false
    @State private var uuidEdit = UUID()
    @State private var newTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(holder.activities) { activity in
                    Button {
                        holder.incrementCounter(for: activity)
                    } label: {
                        HStack {
                            /*@START_MENU_TOKEN@*/Text(activity.title)/*@END_MENU_TOKEN@*/
                                .foregroundColor(.primary)
                                .onTapGesture {
                                    uuidEdit = activity.id
                                    isShowingEditAlert = true
                                }
                            Spacer()
                            Text("\(activity.counter) times")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete { index in
                    deleteActivitys(for: index)
                }
            }
            .navigationTitle("KeepGoing")
            .toolbar {
                Button(action: addNewActivity) {
                    Image(systemName: "plus")
                }
            }
            .alert("New title", isPresented: $isShowingEditAlert) {
                TextField("Title", text: $newTitle)
                Button("OK") {
                    changeTitle()
                }
            }
        }
    }
    
    func deleteActivitys(for indexSet: IndexSet) {
        holder.activities.remove(atOffsets: indexSet)
    }
    
    func addNewActivity() {
        holder.addNew(Activity(title: "New Activity"))
    }
    
    func changeTitle() {
        guard !newTitle.isEmpty else { return }
        holder.changeTitle(for: uuidEdit, to: newTitle)
        uuidEdit = UUID()
        newTitle = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
