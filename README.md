# Landmark

The goal of this project is to scrape HTML from the website https://www.landmarkshops.com and render it in an iOS app.

The approach is as follows:

1. Use `Alamofire` to make a request to the target website, and fetch the response as a String
2. Use `HTMLReader` to parse the HTML response and select the target div (carousel)
3. Load the target div element in the app's `UIWebView` with a given Header and Footer
