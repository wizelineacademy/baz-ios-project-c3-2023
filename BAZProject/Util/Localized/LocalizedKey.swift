//
//  LocalizedKey.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

extension String {
    // MARK: - TheMovieDb API
    static let apiKeyTheMovieDb = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static let theMovieDbBasePath = "https://api.themoviedb.org/3"
    static let theMovieDBBasePathImages = "https://image.tmdb.org/t/p"
    static let languageTheMovieDb = "es"
    static let regionTheMovieDb = "MX"
    static let apiKeyEndPointTrending = "/trending"
    
    // MARK: - ErrorPageView
    static let errorPageXibIdentifier = "ErrorPageView"
    static let nameIcon404 = "notFound"
    static let errorPagePrincipalTitleLabel = " Ups!, ha ocurrido un error..."
    static let retryTitleButton = "Reintentar"
    
    // MARK: - TrendingView
    static let trendingXibIdentifier = "TrendingView"
    static let trendingTitle = "Trending"
    static let trendingTitleUpdateTable = "Actualizando.."
    static let trendingTitleFilterTime = "Filtrar por:"
    static let trendingFilterTitles = ["🍿Pelis", "📺TV", "👀🔝", "Todo"]
    static let trendingFilterByTimeTitles = ["📆Día", "🗓Semana"]
    
    // MARK: - Main
    static let mainPlaceholderSearchBar = "Buscar.."
    static let mainTitleView = "Trending"
    static let mainNameIconTabBar = "house"
    
    // MARK: - CellMovie
    static let cellMovieXibIdentifier = "CellMovie"
    
    // MARK: - InfiniteScrollActivityView
    static let infiniteScrollActivityViewTitleLoading = "Cargando más..."
    
    // MARK: - DetailView
    static let detailXibIdentifier = "DetailView"
}
