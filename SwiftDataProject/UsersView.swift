//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Brendan Chen on 2024.04.07.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        // Underscore accesses the underlying array to apply the query
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
    
    func addSample() {
        let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)
        
        modelContext.insert(user1)
        
        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
    
    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Text(user.name)
                        
                        Spacer()
                        
                        Text(String(user.jobs.count))
                            .fontWeight(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }

                }
            }
            
            Button(action: addSample) {
                Text("Add Sample Data")
            }
        }
    }
}

#Preview {
    UsersView(minimumJoinDate: .distantPast, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
