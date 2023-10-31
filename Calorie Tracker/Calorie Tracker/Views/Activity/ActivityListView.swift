//
//  ActivityListView.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 27/10/2023.
//

import SwiftUI
import CoreData

struct ActivityListView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var activity: FetchedResults<Activity>
    @State private var showingAddActivityView = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Total activity today: "+totalActivityToday())
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(activity) { activity in
                        NavigationLink(destination: EditActivityView(activity: activity)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(activity.activityName!)
                                        .bold()
                                    HStack {
                                        Text("\(calcActivityString(startDate: activity.startDate!, endDate: activity.endDate!))").foregroundColor(.white)
                                        Divider().overlay(.gray).frame(width: 2)
                                        Text("\(Int(activity.calories))") + Text(" Kcal")
                                    }
                                }
                                Spacer()
                                Text("\(activity.date!.formatted(date: .numeric, time: .omitted))")
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteActivity)
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("Activity tracker", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddActivityView.toggle()
                    } label: {
                        Label("Add Activity", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddActivityView) {
                AddActivityView()
            }
        }
    }

    private func deleteActivity(offsets: IndexSet) {
        withAnimation {
            offsets.map { activity[$0] }.forEach(managedObjContext.delete)

            DataController().save(context: managedObjContext)
        }
    }

    private func totalActivityToday() -> String {
        var timeAdded: Int = 0
        for item in activity {
            if Calendar.current.isDateInToday(item.date!) {
                timeAdded += Int((calcActivityInSeconds(startDate: item.startDate!, endDate: item.endDate!)))
            }
        }
        let totalTime = calcSecondsToTotal(seconds: timeAdded)

        return totalTime
    }
}
