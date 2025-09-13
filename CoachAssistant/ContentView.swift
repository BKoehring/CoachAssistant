//
//  ContentView.swift
//  CoachAssistant
//
//  Created by Brandon Koehring on 9/12/25.
//

import SwiftUI

struct PlayerInfo{
    var name: String
    var color: UIColor
    var playNum: Int = 0
}


struct ContentView: View {
    @State var playerListItems = [PlayerInfo]()
    @State var addItemName: String = ""

    @State var colorSelection: UIColor = UIColor.systemRed

    @State var addItem = false
    
    @State private var playNum: Int = 0
    
    @State private var playersOnField = [PlayerInfo]()
    
    @State private var half: Int = 1
    
    @State private var showPlayerDetails: Bool = false
    
    var body: some View {
        VStack {
            HStack{
                Menu("Edit") {
                    Button("New Game"){
                        // Reset for new game
                    }
                    Button("Open Game"){
                        // Open previous game
                    }
                    Button("Save Game"){
                        // Save data of current game
                    }
                    Button("Import Players"){
                        // Import players
                    }
                    Button("Setting"){
                        // Open Settings
                        // Settings should allow for changing minimum plays a player need per half. Default to 7
                    }
                }
                Spacer()
            }
            Text("Coach Assistant").font(.title)
                .padding()
            HStack {
                Text("Half")
                Picker(selection: $half, label: Text("Half")) {
                    Text("1st").tag(1)
                    Text("2nd").tag(2)
                }
                Spacer()
            }.padding()
            VStack {
                HStack{
                    VStack {
                        Text("Player List").font(.title2)
                            .padding()
                        HStack{
                            Menu("Edit List"){
                                Button("Add Player"){
                                    // Open Add Player Menu
                                }
                                Button("Remove Player"){
                                    // Allow for removing players
                                }
                            }
                            Spacer()
                            Text("Sort By")
                            Picker(selection: .constant(1), label: Text("Sort")){
                                Text("Name").tag(1)
                                Text("Play Count").tag(2)
                            }
                        }.padding()
                        List {
                            Button("PlayerName") {
                                PlayerBtnClick(playerName: "Brandon")
                            }
                        }
                    }.padding()
                    VStack{
                        Text("On The Field").font(.title2)
                            .padding()
                        HStack {
                            Stepper("Play: \(playNum)", value: $playNum, in: 0...999)
                                .padding()
                            Button("Clear Field"){
                                // remove all players from the field
                            }
                            .padding()
                        }
                        VStack {
                            HStack {
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())                        }
                            HStack {
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())                        }
                            HStack {
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())
                                Button(action :{
                                    // Do something
                                })
                                {
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        VStack{
                            Text("Player Details").padding()
                            HStack {
                                Text("Name: ")
                                Spacer()
                            }
                            Stepper("Adjust Play Count: \(playNum)", value: $playNum, in: 0...999)
                            Button("Remove From Field"){
                                
                            }.tint(.red)
                            .padding()
                        }
                        .padding()
                        .opacity(showPlayerDetails ? 1 : 0)
                        Spacer()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                        .stroke(.green)
                    )
                    .padding()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
