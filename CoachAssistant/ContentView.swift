//
//  ContentView.swift
//  CoachAssistant
//
//  Created by Brandon Koehring on 9/12/25.
//

import SwiftUI

struct PlayerListRow: View {
    let playerListCircleRadius: CGFloat = 10.0
    
    var playerInfo: PlayerManager.PlayerInfo
    var callBack: () -> Bool
    let minPlaysPerHalf: Int
    @State private var disable_btn = false
    
    var body: some View {
        Button(action: {
            disable_btn = callBack()
        })
        {
            HStack{
                Circle().fill(GetPlayCountColor(playCount: playerInfo.playCount, minPlaysPerHalf: minPlaysPerHalf))
                    .frame(width: playerListCircleRadius, height: playerListCircleRadius)
                Text(playerInfo.playerName)
                Spacer()
                Text("play count: " + String(playerInfo.playCount))
            }
        }
        .disabled(disable_btn)
    }
}

func GetPlayCountColor(playCount: Int, minPlaysPerHalf: Int) -> Color {
    var color: UIColor
    
    let PlayCountPercent: Float = Float(playCount)/Float(minPlaysPerHalf)

    color = UIColor(_colorLiteralRed: 1.0 - PlayCountPercent, green: PlayCountPercent, blue: 0.1, alpha: 1.0)
    
    return Color(uiColor: color)
}

struct GameMenu: View {
    var body: some View {
        HStack {
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
    }
}

struct GameHalfSelector: View{
    
    @State var half: Int = 1
    
    var body: some View{
        HStack {
            Text("Half")
            Picker(selection: $half, label: Text("Half")) {
                Text("1st").tag(1)
                Text("2nd").tag(2)
            }
            Spacer()
        }.padding()    }
}

struct PlayerList: View{
    @State var players: [PlayerManager.PlayerInfo]
    let minPlaysPerHalf: Int
    let callBack: (_: PlayerManager.PlayerInfo) -> Bool
    
    var body: some View{
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
            List(players) { player in
                PlayerListRow(playerInfo: player, callBack: {callBack(player)}, minPlaysPerHalf: minPlaysPerHalf)
            }
        }.padding()
    }
}

struct GameField: View {
    let fieldNumPlayersInRow = [4, 3, 4]
    
    @State var playNum: Int = 0

    @Binding var playersOnField: [PlayerManager.PlayerInfo]
    @State var minPlaysPerHalf: Int

    @State var showPlayerDetails: Bool = false
    
    var body: some View {
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
                ForEach(0..<fieldNumPlayersInRow.count, id: \.self) { rowIndex in
                    HStack{
                        ForEach(0..<fieldNumPlayersInRow[rowIndex], id: \.self) { colIndex in
                            let playerIndex = PlayerManager.GetIndex(playersInRow: fieldNumPlayersInRow, rowIndex: rowIndex, colIndex: colIndex)
                            Button(action: {
                                // Show player details
                            })
                            {
                                if playerIndex < playersOnField.count{
                                    Text(playersOnField[playerIndex].playerName)
                                        .padding()
                                        .background(Circle().fill(GetPlayCountColor(playCount: playersOnField[playerIndex].playCount, minPlaysPerHalf: minPlaysPerHalf)))
                                }
                                else{
                                    Text("Name")
                                        .padding()
                                        .background(Circle().fill(Color.gray))
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
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

struct ContentView: View {
    
    @StateObject var playerManager = PlayerManager()
    
    var body: some View {
        VStack {
            GameMenu()
            Text("Coach Assistant").font(.title)
                .padding()
            var halfSelector: some View = GameHalfSelector()
            VStack {
                HStack{
                    PlayerList(players: playerManager.allPlayers, minPlaysPerHalf: playerManager.minPlaysPerHalf, callBack: playerManager.AddPlayerToField)
                    GameField(playersOnField: $playerManager.playersOnField, minPlaysPerHalf: playerManager.minPlaysPerHalf)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(playerManager: PlayerManager())
}
