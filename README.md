# WeatherAndPollutionApp

This is a simple mobile app built with Flutter that provides real-time weather and air pollution information based on the user's location.

## Technologies and Libraries Used

- **Flutter**: An open-source mobile application development framework used for creating the UI and developing the app.
- **Bloc Pattern**: We use the Bloc architecture to organize the logic and state management of the application. Bloc provides an effective way to manage states and events in the application.
- **http Package**: Utilized to make API requests and communicate with external APIs to fetch weather and air pollution information. (API connections work with tokens provided by the user.)

## Why Did We Use Bloc?

Bloc is a design pattern used to effectively manage complex states and events in an application. This application needs to manage weather and air pollution information that varies based on the user's location. Bloc is an excellent choice for organizing such state management and events.

## Tokens

The application requires specific tokens to communicate with external APIs. You can find these tokens in the `my_data.dart` class. By adding your own API keys and tokens to this class, you can use the application with your platforms.

1- https://openweathermap.org (For weather api, I used free plan)

2- https://waqi.info (For the air pollution api)

## Images from Weather Part

<img src="https://raw.githubusercontent.com/iremsilamadenli/WeatherAndPollutionApp/main/weather_app/assets/morningweather.png" height="500" /><img src="https://raw.githubusercontent.com/iremsilamadenli/WeatherAndPollutionApp/main/weather_app/assets/afterweather.png" height="500" />
<img src="https://raw.githubusercontent.com/iremsilamadenli/WeatherAndPollutionApp/main/weather_app/assets/darkweather.png" height="500" />

## Images from Pollution Part
<img src="https://raw.githubusercontent.com/iremsilamadenli/WeatherAndPollutionApp/main/weather_app/assets/morningpollution.png" height="500" /><img src="https://raw.githubusercontent.com/iremsilamadenli/WeatherAndPollutionApp/main/weather_app/assets/afterpollution.png" height="500" />
<img src="https://raw.githubusercontent.com/iremsilamadenli/WeatherAndPollutionApp/main/weather_app/assets/darkpollution.png" height="500" />


## Installation

1. Clone this repository: `git clone https://github.com/username/WeatherAndPollutionApp.git`
2. Navigate to the project directory: `cd WeatherAndPollutionApp`
3. Install the required packages: `flutter pub get`
4. Run the application: `flutter run`

This mobile app, inspired by the concepts and assets shared by Romain Girou, provides real-time weather and air pollution information based on the user's location.
