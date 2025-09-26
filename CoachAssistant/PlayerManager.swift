//
//  PlayerManager.swift
//  CoachAssistant
//
//  Created by Brandon Koehring on 9/16/25.
//

import SwiftUI

final class PlayerManager : ObservableObject {
    public let TotalPlayersAllowOnField: Int = 11
    
    public struct PlayerInfo : Identifiable{
        let id = UUID()
        var playerName: String = "Missing"
        var playCount: Int = 0
        
        static func ==(lhs: PlayerInfo, rhs: PlayerInfo) -> Bool {
            return (lhs.id == rhs.id)
        }
    }
    
    public init(){
        allPlayers.append(PlayerInfo(playerName: "Brandon"))
        allPlayers.append(PlayerInfo(playerName: "Puka"))
        allPlayers.append(PlayerInfo(playerName: "Matt"))
        allPlayers.append(PlayerInfo(playerName: "Marshall"))
        allPlayers.append(PlayerInfo(playerName: "Cooper"))
        allPlayers.append(PlayerInfo(playerName: "Jared"))
        allPlayers.append(PlayerInfo(playerName: "Byron"))
        allPlayers.append(PlayerInfo(playerName: "Turner"))
        allPlayers.append(PlayerInfo(playerName: "Durant"))
        allPlayers.append(PlayerInfo(playerName: "Kyren"))
        allPlayers.append(PlayerInfo(playerName: "Blake"))
        allPlayers.append(PlayerInfo(playerName: "Josh"))
        allPlayers.append(PlayerInfo(playerName: "Fiske"))
        allPlayers.append(PlayerInfo(playerName: "Witherspoon"))
        allPlayers.append(PlayerInfo(playerName: "Cobie"))
        allPlayers.append(PlayerInfo(playerName: "Nacua"))
        allPlayers.append(PlayerInfo(playerName: "Stafford"))
        allPlayers.append(PlayerInfo(playerName: "Higbee"))
        allPlayers.append(PlayerInfo(playerName: "Davante"))
        allPlayers.append(PlayerInfo(playerName: "Adams"))
        allPlayers.append(PlayerInfo(playerName: "Tutu"))
        allPlayers.append(PlayerInfo(playerName: "Atwell"))
        allPlayers.append(PlayerInfo(playerName: "Verse"))
        allPlayers.append(PlayerInfo(playerName: "Stewert"))
    }
    
    @Published var allPlayers = [PlayerInfo]()
    @Published var playersOnField = [PlayerInfo]()
    @Published var minPlaysPerHalf: Int = 7
    
    public func AddPlayerToField(player: PlayerInfo) -> Bool {
        var success = false
        if playersOnField.count < TotalPlayersAllowOnField {
            playersOnField.append(player)
            success = true
        }
        return success
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
