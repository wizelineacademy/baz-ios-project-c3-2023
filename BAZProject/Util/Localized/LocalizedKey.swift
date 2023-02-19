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
    
    // MARK: - Home
    static let homeTitle = "Inicio"
    static let homeNameIconTabBar = "house"
    
    // MARK: - Trending
    static let trendingXibIdentifier = "TrendingView"
    static let trendingTitle = "Trending"
    static let trendingTitleUpdateTable = "Actualizando.."
    static let trendingTitleFilterTime = "Filtrar por:"
    static let trendingFilterTitles = ["🍿Pelis", "📺TV", "👀🔝", "Todo"]
    static let trendingFilterByTimeTitles = ["📆Día", "🗓Semana"]
    static let trendingNameIconTabBar = "magnifyingglass"
    
    // MARK: - Main
    static let mainPlaceholderSearchBar = "Buscar.."
    
    // MARK: - CellMovie
    static let cellMovieXibIdentifier = "CellMovie"
    
    // MARK: - CellSlider
    static let cellSliderXibIdentifier = "CellSlider"
    
    // MARK: ImageSlider
    static let imageSliderXibIdentifier = "ImageSlider"
    
    // MARK: - InfiniteScrollActivityView
    static let infiniteScrollActivityViewTitleLoading = "Cargando más..."
    
    // MARK: - DetailView
    static let detailXibIdentifier = "DetailView"
}
