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
class HeroElement {
    var id: Int = 0
    var name: String = ""
    var primaryAttr: PrimaryAttr = .agi
    var attackType: AttackType = .melee
    var roles: [Any] = []
    var img = "", icon: String = ""
    var baseHealth: Int = 0
    var baseHealthRegen: Double? = nil
    var baseMana: Int = 0
    var baseManaRegen = 0.0, baseArmor: Double = 0.0
    var baseMr = 0, baseAttackMin = 0, baseAttackMax = 0, baseStr: Int = 0
    var baseAgi = 0, baseInt: Int = 0
    var strGain = 0.0, agiGain = 0.0, intGain: Double = 0.0
    var attackRange = 0, projectileSpeed: Int = 0
    var attackRate: Double = 0.0
    var moveSpeed: Int = 0
    var turnRate: Double? = nil
    
    init(id: Int, name: String, primaryAttr: PrimaryAttr, attackType: AttackType, roles: [Any], img: String, icon: String, baseHealth: Int, baseHealthRegen: Double?, baseMana: Int, baseManaRegen: Double, baseArmor: Double, baseMr: Int, baseAttackMin: Int, baseAttackMax: Int, baseStr: Int, baseAgi: Int, baseInt: Int, strGain: Double, agiGain: Double, intGain: Double, attackRange: Int, projectileSpeed: Int, attackRate: Double, moveSpeed: Int, turnRate: Double?) {
        
        self.id = id
        self.name = name
        self.primaryAttr = primaryAttr
        self.attackType = attackType
        self.roles = roles
        self.img = img
        self.icon = icon
        self.baseHealth = baseHealth
        self.baseHealthRegen = baseHealthRegen
        self.baseMana = baseMana
        self.baseManaRegen = baseManaRegen
        self.baseArmor = baseArmor
        self.baseMr = baseMr
        self.baseAttackMin = baseAttackMin
        self.baseAttackMax = baseAttackMax
        self.baseStr = baseStr
        self.baseAgi = baseStr
        self.baseInt = baseInt
        self.strGain = strGain
        self.agiGain = agiGain
        self.intGain = intGain
        self.attackRange = attackRange
        self.projectileSpeed = projectileSpeed
        self.attackRate = attackRate
        self.moveSpeed = moveSpeed
        self.turnRate = turnRate
    }

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
