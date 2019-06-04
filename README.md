# WeatherAPP

Weather application.

Functionality.

1. View current weather conditions in the list of selected cities.
2. View detailed information with an hourly forecast and a forecast for 5 days.
3. Search for a city by name and add it to the list of cities.
4. The list of cities is stored locally.

Description.

Weather data is getting from the AccuWeather API: https://developer.accuather.com.

Since API subscription is free, there is a limit of 50 requests per day.
Requests are sent:
  - after the application launch - one for each city from the list (request for current weather conditions);
  - when first viewing detailed information on a particular city - 2 requests: hourly weather forecast and 5-day forecast;
  - when searching for a city.

If there are problems with the Internet connection, an alert about it displays on the screen.
If the city search field is filled in incorrectly, an alert about it displays on the screen.

After the application start, the main screen "Cities" is displays. It present a list of cities. After the first start there are 2 cities are available: "Kyiv" and "Vinnytsia".

For each city in the list sent requests for current weather conditions. While receiving information, an animated activity indicator is displayed. After receiving information from the backend, information about current weather conditions appears: icon and temperature. The received data is cached.

By tap on the selected city there are transition to screen "Weather details" with detailed information and hourly forecast, and the 5-days forecast. During the transition, requests are sent for an hourly forecast and a 5-days forecast. During the query, animated activity indicators are displays. After receiving, the information appears on the screen and it's cache. When re-viewing detailed information for the same city information is displayed from the cache.

For the search of a city, there are start typing in the search field is required. The main screen will switch into search mode. To display the search results, the click on the "Search" button is required. A request is sent to the backend to search for a city. During the query, an animated activity indicator is displayed. After the request is executed, a list of cities whose names begin with the phrase that is issued is displayed. To add a city to the list, click the "Add" button is required. To cancel the search, click on the "Back" button is required.

After adding a city or canceling the search, the main screen returns to normal mode. For a newly added city, a request is sent to the backend to obtain current weather conditions.

The cities list is saved in local database.

Приложение для просмотра погоды.

Функциональность.

1. Просмотр текущих погодных условий в списке выбранных городов.
2. Просмотр детальной информации с почасовым прогнозом и прогнозом на 5 дней.
3. Поиск города по названию и добавление его в список городов.
4. Список городов хранится локально.

Описане.

Данные о погоде берутся с API AccuWeather: https://developer.accuweather.com.

Поскольку подписка на API бесплатная, то есть ограничение на 50 запросов в день.
Запросы отправляются:
 - после запуске приложения - по одному для каждого города из списка (запрос текущих погодных условий);
 - при первом просмотре детальной информации по отдельному городу - 2 запроса: почасовой прогноз погоды и прогноз на 5 дней;
 - при поиске города.
 
При проблемах с подключением к интернету на экран выводится сообщение об этом.
При некорректном заполнении поля поиска города на экран выводится сообщение об этом.
 
При запуске приложения отображается главный экран "Cities". На нем отображается список городов. При первом запуске доступны 2 города: "Kyiv" и "Vinnytsia".

Для каждого города в списке отправляются запросы на получение текущих погодных условий. Во время получения информации отображается анимированный индикатор активности. После получения информации с бэкэнда появляется информация о текущих погодных условиях: иконка и температура. Полученные данные кешируются.

По тапу на выбранный город происходит переход на экран "Weather details" с детальной информацией и почасовым прогнозом и прогнозом на 5 дней. Во время перехода отправляются запросы на получение почасового прогноза и прогноза на 5 дней. Во время выполнения запроса отображаются анимированные индикаторы активности. После получения, информация появляется на экране и кешируется. При повторном просмотре детальной информации для этого же города информация отображается из кеша.

Для поиска города необходимо начать ввод в поле поиска. Главный экран переходит в режим поиска. Для вывода результатов поиска необходимо нажать на кнопку "Search". Отправляется запрос на бэкэнд на поиск города. Во время выполнения запроса отображается анимированный индикатор активности. После выполнения запроса отображается список городов, название которых начинается на ввыденную фразу. Для добавления города в список необходимо нажать кнопку "Add". Для отмены поиска необходимо нажать на кнопку "Back".

После добавления города или отмены поиска главный экран переходит в нормальный режим. Для вновь добавленного города отправляется запрос на бэкэнд для получения текущих погодных условий.

Список городов хранится в локальной базе данных.
