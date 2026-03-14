param($lat, $lon, $units, $dataFile)
$url = "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code&wind_speed_unit=kmh&temperature_unit=$units"
$data = Invoke-RestMethod $url
$temp = $data.current.temperature_2m
$hum  = $data.current.relative_humidity_2m
$wind = $data.current.wind_speed_10m
$code = [int]$data.current.weather_code
$phrases = @{0="Clear";1="Mostly Clear";2="Partly Cloudy";3="Overcast";45="Foggy";48="Icy Fog";51="Light Drizzle";53="Drizzle";55="Heavy Drizzle";61="Light Rain";63="Rain";65="Heavy Rain";71="Light Snow";73="Snow";75="Heavy Snow";80="Light Showers";81="Showers";82="Heavy Showers";95="Thunderstorm";96="Thunderstorm+Hail";99="Heavy Thunderstorm"}
$phrase = if ($phrases.ContainsKey($code)) { $phrases[$code] } else { "Code $code" }
$content = [System.IO.File]::ReadAllText($dataFile, [System.Text.Encoding]::Unicode)
$content = $content -replace 'Weather\.Temp=.*', "Weather.Temp=$temp"
$content = $content -replace 'Weather\.Humidity=.*', "Weather.Humidity=$hum"
$content = $content -replace 'Weather\.Wind\.Speed=.*', "Weather.Wind.Speed=$wind"
$content = $content -replace 'Weather\.Phrase=.*', "Weather.Phrase=$phrase"
[System.IO.File]::WriteAllText($dataFile, $content, [System.Text.Encoding]::Unicode)
