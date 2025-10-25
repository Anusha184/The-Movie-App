# The-Movie-App
Movie app with The Movie Database (TMDb) 
MovieApp

A SwiftUI-based iOS application that displays a list of movies from TMDb (The Movie Database). Users can search for movies, view detailed information including trailers, and mark movies as favorites.

# Setup

Clone the repository:
git clone https://github.com/Anusha184/The-Movie-App.git
cd MovieApp

TMDb API Key
Sign up at TMDb and obtain an API key.
Add the key to secrets .plist file:
private let apiKey = "API_KEY"

Install dependencies 

Build and run
Open MovieApp.xcodeproj in Xcode 17+
Select target device/simulator
Press Run (Cmd + R)

# Assumptions

- Favorite movies are stored locally using UserDefaults.
- Movie data fetched from TMDb is used as-is; isFav is added locally for UI state.
- Trailer playback is limited to YouTube embeds.
- Search is performed by movie title only.

# Features

- Fetch and display popular movies from TMDb.
- Search movies by title.
- View detailed movie information: Title, genres, rating, runtime, and overview.
- Trailer playback using YouTube.
- Mark movies as favorites, persisted locally using UserDefaults.
- Dynamic UI updates when toggling favorites.

# Known Limitations

- runtime is not displayed in list view and cast is not displayed in detail view (No key in api response)
- MovieListViewModel directly depends on UserDefaults. MovieDetailView depends on MovieListViewModel. For better scalability can introduce a FavoritesManager and use bindings or callbacks to update state.
- API errors are shown as plain text; no retry logic implemented.
- Trailer playback is limited to available YouTube keys.
- No offline caching; requires an internet connection to fetch movies.
