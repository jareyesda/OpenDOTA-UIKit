//
//  Hero.swift
//  OpenDotaAPI-UIKit
//
//  Created by Juan Reyes on 5/27/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hero = try? newJSONDecoder().decode(Hero.self, from: jsonData)

import Foundation

// MARK: - HeroElement
struct HeroElement {
    let id: Int
    let name: String
    let primaryAttr: PrimaryAttr
    let attackType: AttackType
    let roles: [Any]
    let img, icon: String
    let baseHealth: Int
    let baseHealthRegen: Double?
    let baseMana: Int
    let baseManaRegen, baseArmor: Double
    let baseMr, baseAttackMin, baseAttackMax, baseStr: Int
    let baseAgi, baseInt: Int
    let strGain, agiGain, intGain: Double
    let attackRange, projectileSpeed: Int
    let attackRate: Double
    let moveSpeed: Int
    let turnRate: Double?

    enum CodingKeys: String, CodingKey {
        case id, name
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles, img, icon
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseArmor = "base_armor"
        case baseMr = "base_mr"
        case baseAttackMin = "base_attack_min"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case strGain = "str_gain"
        case agiGain = "agi_gain"
        case intGain = "int_gain"
        case attackRange = "attack_range"
        case projectileSpeed = "projectile_speed"
        case attackRate = "attack_rate"
        case moveSpeed = "move_speed"
        case turnRate = "turn_rate"
    }
}

enum AttackType: String, Codable {
    case melee = "Melee"
    case ranged = "Ranged"
}

enum PrimaryAttr: String, Codable {
    case agi = "agi"
    case int = "int"
    case str = "str"
}

enum Role: String, Codable {
    case carry = "Carry"
    case disabler = "Disabler"
    case durable = "Durable"
    case escape = "Escape"
    case initiator = "Initiator"
    case jungler = "Jungler"
    case nuker = "Nuker"
    case pusher = "Pusher"
    case support = "Support"
}

typealias Hero = [HeroElement]
