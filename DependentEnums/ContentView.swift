//
//  ContentView.swift
//  DependentEnums
//
//  Created by David on 18/04/2023.
//

import SwiftUI

enum League: String, CaseIterable {
    case LaLiga = "LaLiga"
    case PremierLeague = "Premier League"
    case Bundesliga = "Bundesliga"
}

enum Team: String, CaseIterable {
    // La Liga
    case almeria = "Almería"
    case athleticClubBilbao = "Athletic Club Bilbao"
    case atleticoMadrid = "Atlético Madrid"
    case barcelona = "FC Barcelona"
    case cadizCF = "Cádiz CF"
    case celtaVigo = "RC Celta de Vigo"
    case elcheCF = "Elche CF"
    case espanyol = "Espanyol"
    case getafeCF = "Getafe CF"
    case girona = "Girona"
    case mallorca = "RCD Mallorca"
    case osasuna = "CA Osasuna"
    case rayoVallecano = "Rayo Vallecano"
    case realBetis = "Real Betis"
    case realMadrid = "Real Madrid"
    case realSociedad = "Real Sociedad"
    case sevilla = "Sevilla FC"
    case valenciaCF = "Valencia CF"
    case valladolid = "Valladolid"
    case villarrealCF = "Villarreal CF"

    // Premier League
    case arsenal = "Arsenal"
    case astonVilla = "Aston Villa"
    case bournemouth = "Bournemouth"
    case brentford = "Brentford"
    case brighton = "Brighton & Hove Albion"
    case chelsea = "Chelsea"
    case crystalPalace = "Crystal Palace"
    case everton = "Everton"
    case fcRichmond = "FC Richmond"
    case fulham = "Fulham"
    case leedsUnited = "Leeds United"
    case leicesterCity = "Leicester City"
    case liverpool = "Liverpool"
    case manchesterCity = "Manchester City"
    case manchesterUnited = "Manchester United"
    case newcastleUnited = "Newcastle United"
    case nottinghamForest = "Nottingham Forest"
    case southampton = "Southampton"
    case tottenhamHotspur = "Tottenham Hotspur"
    case westHamUnited = "West Ham United"
    case wolves = "Wolves"
    
    // Bundesliga
    case bayerLeverkusen = "Bayer Leverkusen"
    case bayernMunich = "Bayern Munich"
    case borussiaDortmund = "Borussia Dortmund"
    case borussiaMonchengladbach = "Borussia Mönchengladbach"
    case eintrachtFrankfurt = "Eintracht Frankfurt"
    case fcAugsburg = "FC Augsburg"
    case fcKoln = "FC Köln"
    case fcUnionBerlin = "1. FC Union Berlin"
    case herthaBsc = "Hertha BSC"
    case hoffenheim = "TSG Hoffenheim"
    case mainz05 = "1. FSV Mainz 05"
    case rbLeipzig = "RB Leipzig"
    case scFreiburg = "SC Freiburg"
    case schalke04 = "FC Schalke 04"
    case vfbStuttgart = "VfB Stuttgart"
    case vflBochum = "VfL Bochum 1848"
    case vflWolfsburg = "VfL Wolfsburg"
    case werderBremen = "Werder Bremen"}

func getSubRange<T: CaseIterable & Equatable>(from start: T, to end: T) -> [T] {
    guard let startIndex = T.allCases.firstIndex(of: start),
          let endIndex = T.allCases.firstIndex(of: end) else {
        return []
    }

    let range = (startIndex...endIndex)
    let subRange = Array(T.allCases[range])

    if startIndex > endIndex {
        return subRange.reversed()
    } else {
        return subRange
    }
}

func getHomeTeams(for league: League) -> [Team] {
    switch league {
        case .LaLiga:
            return getSubRange(from: Team.almeria, to: Team.villarrealCF)
        case .PremierLeague:
        return getSubRange(from: Team.arsenal, to: Team.wolves)
        case .Bundesliga:
            return getSubRange(from: Team.bayerLeverkusen, to: Team.werderBremen)
    }
}

func getAwayTeams(for league: League, ignoring homeTeam: Team) -> [Team] {
    return getHomeTeams(for: league).filter { $0 != homeTeam }
}

struct DependentEnums: View {
    @State var league: League? {
        didSet {
            homeTeam = nil
            awayTeam = nil
        }
    }
    
    @State var homeTeam: Team? {
        didSet {
            awayTeam = nil
        }
    }
    
    @State var awayTeam: Team?
    
    var body: some View {
        Form {
            Picker("League", selection: $league) {
                Text ("Pick a league")
                    .tag(nil as League?)
                
                ForEach(League.allCases, id: \.self) { league in
                    Text (league.rawValue)
                        .tag(league as League?)
                }
            }
            
            if let league = league {
                Picker("Home Team", selection: $homeTeam) {
                    Text ("Pick a team")
                        .tag(nil as Team?)
                    
                    ForEach(getHomeTeams(for: league), id: \.self) { team in
                        Text(team.rawValue)
                            .tag(team as Team?)

                    }
                }

                if let homeTeam = homeTeam {
                    Picker("Away Team", selection: $awayTeam) {
                        Text ("Pick a team")
                            .tag(nil as Team?)
                        
                        ForEach(getAwayTeams(for: league, ignoring: homeTeam), id: \.self) { team in
                            Text(team.rawValue)
                                .tag(team as Team?)

                        }
                    }
                }
            }
        }
    }
}

struct RelatedEnums_Previews: PreviewProvider {
    static var previews: some View {
        DependentEnums()
    }
}
