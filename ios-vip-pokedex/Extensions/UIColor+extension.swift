//
//  UIColor.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 10/07/23.
//

import UIKit

extension UIColor {
    
    enum PokemonColor: String {
        case fighting = "fighting"
        case flying = "flying"
        case poison = "poison"
        case ground = "ground"
        case rock = "rock"
        case bug = "bug"
        case ghost = "ghost"
        case steel = "steel"
        case fire = "fire"
        case water = "water"
        case grass = "grass"
        case electric = "electric"
        case psychic = "psychic"
        case ice = "ice"
        case dragon = "dragon"
        case dark = "dark"
        case fairy = "fairy"
        case normal = "normal"
    }
    
    struct PokemonColorType {
        static var fighting = UIColor(named: PokemonColor.fighting.rawValue)!
        static var flying = UIColor(named: PokemonColor.flying.rawValue)!
        static var poison = UIColor(named: PokemonColor.poison.rawValue)!
        static var ground = UIColor(named: PokemonColor.ground.rawValue)!
        static var rock = UIColor(named: PokemonColor.rock.rawValue)!
        static var bug = UIColor(named: PokemonColor.bug.rawValue)!
        static var ghost = UIColor(named: PokemonColor.ghost.rawValue)!
        static var steel = UIColor(named: PokemonColor.steel.rawValue)!
        static var fire = UIColor(named: PokemonColor.fire.rawValue)!
        static var water = UIColor(named: PokemonColor.water.rawValue)!
        static var grass = UIColor(named: PokemonColor.grass.rawValue)!
        static var electric = UIColor(named: PokemonColor.electric.rawValue)!
        static var psychic = UIColor(named: PokemonColor.psychic.rawValue)!
        static var ice = UIColor(named: PokemonColor.ice.rawValue)!
        static var dragon = UIColor(named: PokemonColor.dragon.rawValue)!
        static var dark = UIColor(named: PokemonColor.dark.rawValue)!
        static var fairy = UIColor(named: PokemonColor.fairy.rawValue)!
        static var normal = UIColor(named: PokemonColor.normal.rawValue)!
        
        static func parsePokemonColor(type: String) -> UIColor {
            switch type {
            case "fighting": return UIColor.PokemonColorType.fighting
            case "flying": return UIColor.PokemonColorType.flying
            case "poison": return UIColor.PokemonColorType.poison
            case "ground": return UIColor.PokemonColorType.ground
            case "rock": return UIColor.PokemonColorType.rock
            case "bug": return UIColor.PokemonColorType.bug
            case "ghost": return UIColor.PokemonColorType.ghost
            case "steel": return UIColor.PokemonColorType.steel
            case "fire": return UIColor.PokemonColorType.fire
            case "water": return UIColor.PokemonColorType.water
            case "grass": return UIColor.PokemonColorType.grass
            case "electric": return UIColor.PokemonColorType.electric
            case "psychic": return UIColor.PokemonColorType.psychic
            case "ice": return UIColor.PokemonColorType.ice
            case "dragon": return UIColor.PokemonColorType.dragon
            case "dark": return UIColor.PokemonColorType.dark
            case "fairy": return UIColor.PokemonColorType.fairy
            default:
                return UIColor.PokemonColorType.normal
            }
        }
    }
}
