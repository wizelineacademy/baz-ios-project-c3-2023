//
//  LocalizedKey.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

extension String {
    // MARK: - Commons
    static let commonTitleShowAlertLoading = "Cargando.."
    static let commonMessageShowAlertLoading = "Por favor espere."

    // MARK: - TheMovieDb API
    static let apiKeyTheMovieDb = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static let theMovieDbBasePath = "https://api.themoviedb.org/3"
    static let theMovieDBBasePathImages = "https://image.tmdb.org/t/p"
    static let apiLang = "es"
    static let apiRegion = "MX"
    static let apiKeyEndPointTrending = "/trending"
    static let apiKeyEndPointMovieTopRated = "/movie/top_rated"
    static let apiKeyEndPointMovie = "/movie"
    static let apiKeyEndPointMovieSearch = "/search/movie"
    static let apiKeyEndPointNowPlaying = "/movie/now_playing"
    static let theMovieDbEndBaseUrl = "?api_key=\(apiKeyTheMovieDb)&language=\(apiLang)&region=\(apiRegion)"
    static let theMovieDbAppendImages = "&append_to_response=images&include_image_language=\(apiLang),null"

    // MARK: - ErrorPageView
    static let errorPageXibIdentifier = "ErrorPageView"
    static let nameIcon404 = "notFound"
    static let errorPagePrincipalTitleLabel = " Ups!, ha ocurrido un error..."
    static let retryTitleButton = "Reintentar"

    // MARK: - Home
    static let homeXibIdentifier = "HomeView"
    static let homeTitle = "Inicio"
    static let homeNameIconTabBar = "house"
    static let homeTitleNowPlaying = "En cines"

    // MARK: - Trending
    static let trendingXibIdentifier = "TrendingView"
    static let trendingTitle = "Trending"
    static let trendingTitleUpdateTable = "Actualizando.."
    static let trendingTitleFilterTime = "Filtrar por:"
    static let trendingFilterTitles = ["🍿Pelis", "📺TV", "👀🔝", "Todo"]
    static let trendingFilterByTimeTitles = ["📆Día", "🗓Semana"]
    static let trendingNameIconTabBar = "magnifyingglass"

    // MARK: - Review
    static let reviewXibIdentifier = "ReviewView"

    // MARK: - Main
    static let mainPlaceholderSearchBar = "Buscar.."

    // MARK: - CellMovie
    static let cellMovieXibIdentifier = "CellMovie"

    // MARK: - CellSlider
    static let cellSliderXibIdentifier = "CellSlider"

    // MARK: - CellMovieTop
    static let cellMovieTopXibIdentifier = "CellMovieTop"

    // MARK: - CellReview
    static let cellReviewXibIdentifier = "CellReview"
    static let cellReviewTitleShowMore = "Mostrar más"
    static let cellReviewTitleHide = "Ocultar"
    static let cellReviewWriteOn = "Escrito el"
    static let cellReviewWriteBy = "Escrito por:"

    // MARK: - CellEmptyState
    static let cellEmptyStateXibIdentifier = "CellEmptyState"

    // MARK: ImageSlider
    static let imageSliderXibIdentifier = "ImageSlider"

    // MARK: - InfiniteScrollActivityView
    static let infiniteScrollActivityViewTitleLoading = "Cargando más..."

    // MARK: - DetailView
    static let detailXibIdentifier = "DetailView"
    static let detailViewReviewTitle = "Reseñas:"
    static let detailShowAllTitle = "Mostrar todas"
    static let detailReviewsEmptyState = "No se cuenta con reseñas aún."
    static let detailTitleSimilarMovies = "Películas similares:"

    // MARK: StarRated
    static let starRatedXibIdentifier = "StarRatedView"
}
