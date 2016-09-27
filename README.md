# Landmark

The goal of this project is to scrape HTML from the website https://www.landmarkshops.com and render it natively in an iOS app.

The approach is as follows:

1. Use `Alamofire` to make a request to the target website, and fetch the response as a String
2. Use `HTMLReader` to parse the HTML response, select the target div (carousel) and map it to a model class, `Product`
3. Render the `Product` array using a `UICollectionView`

# Libraries Used

1. `Alamofire`, to load the HTML data
2. `HTMLReader` to parse through HTML
3. `SDWebImage` to asynchronously download & cache images

# Dependencies

1. Xcode 7.2.1
2. Swift 2.2
3. Cocoapods 1.0.0

# Enhancements
Instead of showing the same carousel each time, the app has been enhanced to randomly select one of the available carousels.
