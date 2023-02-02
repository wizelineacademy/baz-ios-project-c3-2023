//
//  Movie.swift
//  BAZProject
//
//

enum RateValue: String {
    case bad = "⭐️"
    case low = "⭐️⭐️"
    case medium = "⭐️⭐️⭐️"
    case higth = "⭐️⭐️⭐️⭐️"
    case better = "⭐️⭐️⭐️⭐️⭐️"
    
}

struct RateViewModel{
    let movieRate: Double
    
    var movieEmojiRate: RateValue{
        switch movieRate {
        case 0..<2:
            return .bad
        case 2..<4:
            return .low
        case 4..<6:
            return .medium
        case 6..<8:
            return .higth
        case 8...10:
            return .better
        default:
            return .low
        }
    }
}
