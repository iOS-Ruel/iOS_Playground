//
//  AddJournalEntryView.swift
//  JRNL_SwiftUI
//
//  Created by Chung Wussup on 5/28/24.
//

import SwiftUI
import CoreLocation



struct AddJournalEntryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var isGetLocationOn = false
    @State private var entryTitle = ""
    @State private var entryBody = ""
    @State private var rating = 0
    @State private var locationLabel = "Get Location"
    @State private var currentLocation: CLLocation?
    @State private var isShowPicker = false
    @State private var uiImage: UIImage?
    
    @StateObject private var locationManager = LocationMananger()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Rating")) {
                    RatingView(rating: $rating)
                }
                Section(header: Text("Location")) {
                    Toggle(locationLabel, isOn: $isGetLocationOn)
                        .onChange(of: isGetLocationOn) {
                            if isGetLocationOn {
                                locationManager.requestLocation()
                                locationLabel = "Get Location..."
                            } else {
                                locationLabel = "Get Location"
                            }
                        }
                        .onReceive(locationManager.$location) { location in
                            if isGetLocationOn {
                                currentLocation = location
                                locationLabel = "Done"
                            }
                        }
                }
                
                Section(header: Text("Title")) {
                    TextField("Enter Title", text: $entryTitle)
                }
                
                Section(header: Text("Body")) {
                    TextEditor(text: $entryBody)
                }
                
                Section(header: Text("Photo")) {
                    imageView()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding()
                        .onTapGesture {
                            isShowPicker = true
                        }
                }
            }
            .navigationTitle("Add Journal Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                        let journalEntry = JournalEntry(rating: 3, entryTitle: entryTitle, entryBody: entryBody, latitude: currentLocation?.coordinate.latitude, longitude: currentLocation?.coordinate.longitude,
                                                        photo: uiImage)
                        
                        modelContext.insert(journalEntry)
                        
                        dismiss()
                    } label: {
                        Text("save")
                    }
                }
            }
            .sheet(isPresented: $isShowPicker) {
                ImagePicker(image: $uiImage)
            }
            
        }
    }
    
    func imageView() -> some View {
        if let image = uiImage {
            return Image(uiImage: image)
                .resizable()
        } else {
            return Image(systemName: "smiley")
                .resizable()
        }
    }
}

#Preview {
    AddJournalEntryView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
