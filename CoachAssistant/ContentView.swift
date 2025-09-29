//
//  ContentView.swift
//  CoachAssistant
//
//  Created by Brandon Koehring on 9/12/25.
//

import SwiftUI

struct PlayerListRow: View {
    let playerListCircleRadius: CGFloat = 10.0
    
    @StateObject var playerInfo: PlayerManager.PlayerInfo
    var callBack: () -> Void
    let minPlaysPerHalf: Int
    
    var body: some View {
        Button(action: {
            callBack()
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
        .disabled(playerInfo.onField)
    }
}

func GetPlayCountColor(playCount: Int, minPlaysPerHalf: Int) -> Color {
    var color: UIColor
    let max_g_value: Float = 0.8
    let max_r_value: Float = 0.8
    let max_b_value: Float = 0.2
    let red_drop_off: Float = 10.0
    let green_increase: Float = 1.0/3.0
    
    var PlayCountPercent: Float = Float(playCount)/Float(minPlaysPerHalf)
    if PlayCountPercent > 1.0{
        PlayCountPercent = 1.0
    }
    let red: Float = max_r_value - pow(PlayCountPercent, red_drop_off) * max_r_value
    let green: Float = pow(PlayCountPercent, green_increase) * max_g_value
    let blue: Float = PlayCountPercent * max_b_value

    color = UIColor(_colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
    
    return Color(uiColor: color)
}

struct PlayerCircle: View {
    let radius: CGFloat = 60.0
    var playerNumber: String
    var circleColor: Color
    
    var body: some View {
        Text(playerNumber)
            .padding()
            .background(Circle().fill(circleColor).frame(width: radius, height: radius))
    }
}

struct GameMenu: View {
    @Binding var documentPickerToggle: Bool
    
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
                    documentPickerToggle.toggle()
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
    @Binding var players: [PlayerManager.PlayerInfo]
    let minPlaysPerHalf: Int
    let callBack: (_: PlayerManager.PlayerInfo) -> Void
    
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
    let circle_radius: Int = 100
    
    @State var playNum: Int = 0

    @Binding var playersOnField: [PlayerManager.PlayerInfo]
    @State var minPlaysPerHalf: Int

    @State var selectedPlayer: Int = -1
    
    var clearField: () -> Void
    var removePlayer: (Int) -> Void
    var IncrementPlay: () -> Void
    var DecrementPlay: () -> Void
    
    var body: some View {
        VStack{
            Text("On The Field").font(.title2)
                .padding()
            HStack {
                Stepper{
                    Text("Play: \(playNum)")
                }
                onIncrement: {
                    playNum += 1
                    IncrementPlay()
                }
                onDecrement: {
                    if playNum > 0{
                        playNum -= 1
                        DecrementPlay()
                    }
                }
                .padding()
                Button("Clear Field"){
                    selectedPlayer = -1
                    clearField()
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
                                selectedPlayer = playerIndex == selectedPlayer ? -1 : playerIndex
                            })
                            {
                                if playerIndex < playersOnField.count{
                                    PlayerCircle(playerNumber: playersOnField[playerIndex].playerNumber, circleColor: GetPlayCountColor(playCount: playersOnField[playerIndex].playCount, minPlaysPerHalf: minPlaysPerHalf)).padding()
                                }
                                else{
                                    PlayerCircle(playerNumber: "", circleColor: Color.gray).padding()
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            VStack{
                if selectedPlayer > -1 && selectedPlayer < playersOnField.count {
                    let player = playersOnField[selectedPlayer]
                    Text("Player Details").padding()
                    HStack {
                        Text("Name: " + player.playerName)
                        Spacer()
                    }
                    HStack{
                        Text("#" + player.playerNumber)
                        Spacer()
                    }
                    HStack{
                        Text("Position: " + player.playerPosition)
                        Spacer()
                    }
                    Stepper("Adjust Play Count: \(playersOnField[selectedPlayer].playCount)", value: $playersOnField[selectedPlayer].playCount, in: 0...999)
                    Button("Remove From Field"){
                        removePlayer(selectedPlayer)
                        selectedPlayer = -1
                    }.tint(.red)
                        .padding()
                }
            }
            .padding()
            .opacity(selectedPlayer != -1 ? 1 : 0)
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
    @State var documentPickerToggle = false
    
    var body: some View {
        VStack {
            GameMenu(documentPickerToggle: $documentPickerToggle)
            Text("Coach Assistant").font(.title)
                .padding()
            var halfSelector: some View = GameHalfSelector()
            VStack {
                HStack{
                    PlayerList(players: $playerManager.allPlayers, minPlaysPerHalf: playerManager.minPlaysPerHalf, callBack: playerManager.AddPlayerToField)
                    GameField(playersOnField: $playerManager.playersOnField, minPlaysPerHalf: playerManager.minPlaysPerHalf, clearField: playerManager.ClearField, removePlayer: playerManager.RemovePlayerFromField,
                        IncrementPlay: playerManager.IncrementPlay,
                        DecrementPlay: playerManager.DecrementPlay)
                }
            }
            .fileImporter(isPresented: $documentPickerToggle, allowedContentTypes: [.commaSeparatedText], allowsMultipleSelection: false, onCompletion: playerManager.readInPlayers)
        }
        .padding()
    }
}

#Preview {
    ContentView(playerManager: PlayerManager())
}
