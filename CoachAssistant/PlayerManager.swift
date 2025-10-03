//
//  PlayerManager.swift
//  CoachAssistant
//
//  Created by Brandon Koehring on 9/16/25.
//

import SwiftUI

final class PlayerManager : ObservableObject {
    public let TotalPlayersAllowOnField: Int = 11
    
    public class PlayerInfo : Identifiable, ObservableObject{
        let id = UUID()
        var playerName: String = "Missing"
        var playerNumber: String = "Missing"
        var playerPosition: String = "Missing"
        @Published var playCountForHalf: [Int] = [0, 0]
        @Published var onField: Bool = false
        
        public init(name: String, number: String, position: String){
            playerName = name
            playerNumber = number
            playerPosition = position
        }
        
        static func ==(lhs: PlayerInfo, rhs: PlayerInfo) -> Bool {
            return (lhs.id == rhs.id)
        }
    }
    
    @Published var allPlayers = [PlayerInfo]()
    @Published var playersOnField = [PlayerInfo]()
    @Published var minPlaysPerHalf: Int = 7
    @Published var playCountForHalf: [Int] = [0, 0]
    
    func readInPlayers(result: Result<[URL], any Error>) -> Void{
        allPlayers.removeAll()
        var data = ""
        do{
            let files = try result.get()
            if files[0].startAccessingSecurityScopedResource() {
                data = try String(contentsOf: files[0], encoding: String.Encoding.ascii)
            }
        }
        catch {
            print("Error: \(error)")
        }
        
        var rows = data.components(separatedBy: "\n")
        rows.removeFirst()
        for row in rows {
            let columns = row.components(separatedBy: ",")
            print(columns)
            if columns.count == 3{
                AddPlayerToList(player: PlayerInfo(name: columns[0], number: columns[1], position: columns[2]))
            }
        }
    }
    
    public func AddPlayerToList(player: PlayerInfo) -> Void {
        allPlayers.append(player)
    }
    
    public func AddPlayerToField(player: PlayerInfo) -> Void {
        if playersOnField.count < TotalPlayersAllowOnField {
            playersOnField.append(player)
            player.onField = true
        }
    }
    
    public func RemovePlayerFromField(index: Int) -> Void {
        if index < playersOnField.count {
            playersOnField[index].onField = false
            playersOnField.remove(at: index)
        }
    }
    
    public func ClearField() -> Void {
        for index in 0..<playersOnField.count {
            playersOnField[index].onField = false
        }
        playersOnField.removeAll()
    }
    
    public func IncrementPlay(half: Int) -> Void {
        for index in 0..<playersOnField.count {
            playersOnField[index].playCountForHalf[half] += 1
        }
    }
    
    public func DecrementPlay(half: Int) -> Void {
        for index in 0..<playersOnField.count {
            if playersOnField[index].playCountForHalf[half] > 0{
                playersOnField[index].playCountForHalf[half] -= 1
            }
        }
    }
    
    public static func GetIndex(playersInRow: [Int], rowIndex: Int, colIndex: Int) -> Int{
        var index: Int = 0
        for row in 0..<rowIndex {
            index += playersInRow[row]
        }
        index += colIndex

        return index
    }
}
