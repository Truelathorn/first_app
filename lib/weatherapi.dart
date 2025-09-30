import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  final String city;
  final double temperature;
  final String description;

  Weather(this.city, this.temperature, this.description);

  Weather.fromJson(Map<String, dynamic> json)
      : city = json['data']['city']['name'] ?? 'Unknown',
        temperature = json['data']['iaqi']['t']?['v']?.toDouble() ?? 0.0,
        description = json['data']['dominentpol'] ?? 'N/A';
}

class AirQuality {
  final int aqi;

  AirQuality(this.aqi);

  AirQuality.fromJson(Map<String, dynamic> json)
      : aqi = json['data']['aqi'] ?? 0;
}

class WeatherApi extends StatefulWidget {
  const WeatherApi({super.key});

  @override
  State<WeatherApi> createState() => _WeatherApiState();
}

class _WeatherApiState extends State<WeatherApi> {
  Weather? weather;
  AirQuality? airQuality;
  bool isLoading = true;

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
    });
    const apiKey = '706b91fa8b54d681f710397c149ade5e4f81443f';
    final url = Uri.parse('https://api.waqi.info/feed/here/?token=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Weather w = Weather.fromJson(data);
        AirQuality aqi = AirQuality.fromJson(data);

        setState(() {
          weather = w;
          airQuality = aqi;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        weather = Weather('Error', 0.0, e.toString());
        airQuality = AirQuality(0);
      });
    }
  }

  Color getAqiColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    if (aqi <= 300) return Colors.purple;
    return Colors.brown;
  }

  Widget observationCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.black54),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        // Header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.orange.shade300, Colors.orange.shade100],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                weather!.city,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Updated just now',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white70),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                '${airQuality!.aqi}',
                                style: TextStyle(
                                  fontSize: 72,
                                  fontWeight: FontWeight.bold,
                                  color: getAqiColor(airQuality!.aqi),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                airQuality!.aqi <= 50
                                    ? "Good"
                                    : airQuality!.aqi <= 100
                                        ? "Moderate"
                                        : airQuality!.aqi <= 150
                                            ? "Unhealthy for Sensitive Groups"
                                            : airQuality!.aqi <= 200
                                                ? "Unhealthy"
                                                : airQuality!.aqi <= 300
                                                    ? "Very Unhealthy"
                                                    : "Hazardous",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Observation
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Current Observation',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                childAspectRatio: 3,
                                children: [
                                  observationCard(
                                      'Temperature',
                                      '${weather!.temperature.toStringAsFixed(1)} °C',
                                      Icons.thermostat_outlined),
                                  observationCard(
                                      'AQI',
                                      '${airQuality!.aqi}',
                                      Icons.air),
                                  observationCard(
                                      'Dominant Pollutant',
                                      weather!.description.toUpperCase(),
                                      Icons.warning_amber_rounded),
                                ],
                              ),
                              const SizedBox(height: 24),
                              // Refresh Button
                              Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: fetchWeather,
                                    icon: const Icon(Icons.refresh, size: 24),
                                    label: const Text(
                                      'Refresh',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 5,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
