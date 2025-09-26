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
        @Published var playCount: Int = 0
        @Published var onField: Bool = false
        
        public init(name: String){
            playerName = name
        }
        
        static func ==(lhs: PlayerInfo, rhs: PlayerInfo) -> Bool {
            return (lhs.id == rhs.id)
        }
    }
    
    public init(){
        allPlayers.append(PlayerInfo(name: "Brandon"))
        allPlayers.append(PlayerInfo(name: "Puka"))
        allPlayers.append(PlayerInfo(name: "Matt"))
        allPlayers.append(PlayerInfo(name: "Marshall"))
        allPlayers.append(PlayerInfo(name: "Cooper"))
        allPlayers.append(PlayerInfo(name: "Jared"))
        allPlayers.append(PlayerInfo(name: "Byron"))
        allPlayers.append(PlayerInfo(name: "Turner"))
        allPlayers.append(PlayerInfo(name: "Durant"))
        allPlayers.append(PlayerInfo(name: "Kyren"))
        allPlayers.append(PlayerInfo(name: "Blake"))
        allPlayers.append(PlayerInfo(name: "Josh"))
        allPlayers.append(PlayerInfo(name: "Fiske"))
        allPlayers.append(PlayerInfo(name: "Witherspoon"))
        allPlayers.append(PlayerInfo(name: "Cobie"))
        allPlayers.append(PlayerInfo(name: "Nacua"))
        allPlayers.append(PlayerInfo(name: "Stafford"))
        allPlayers.append(PlayerInfo(name: "Higbee"))
        allPlayers.append(PlayerInfo(name: "Davante"))
        allPlayers.append(PlayerInfo(name: "Adams"))
        allPlayers.append(PlayerInfo(name: "Tutu"))
        allPlayers.append(PlayerInfo(name: "Atwell"))
        allPlayers.append(PlayerInfo(name: "Verse"))
        allPlayers.append(PlayerInfo(name: "Stewert"))
    }
    
    @Published var allPlayers = [PlayerInfo]()
    @Published var playersOnField = [PlayerInfo]()
    @Published var minPlaysPerHalf: Int = 7
    
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
    
    public static func GetIndex(playersInRow: [Int], rowIndex: Int, colIndex: Int) -> Int{
        var index: Int = 0
        for row in 0..<rowIndex {
            index += playersInRow[row]
        }
        index += colIndex

        return index
    }
}
