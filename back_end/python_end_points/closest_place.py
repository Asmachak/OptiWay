import pandas as pd
import requests
import math

# Replace with your actual Google Maps Geocoding API key
API_KEY = "AIzaSyAz6XzOp2eIEPWI2LyXkUQU5fURTRk3_4o"

def get_coordinates(place_name):
    url = f"https://maps.googleapis.com/maps/api/geocode/json?address={place_name}&key={API_KEY}"
    response = requests.get(url)
    data = response.json()
    
    if data['status'] == 'OK':
        location = data['results'][0]['geometry']['location']
        return location['lat'], location['lng']
    else:
        print(f"Error fetching coordinates for {place_name}")
        return None, None

def haversine(lat1, lon1, lat2, lon2):
    R = 6371  # Earth radius in kilometers
    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    a = math.sin(dlat / 2) ** 2 + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dlon / 2) ** 2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    distance = R * c
    return distance

def fetch_parkings_from_csv(file_path):
    try:
        df = pd.read_csv(file_path, dtype={'location': str})
        
        # Filter rows where location is not null
        df = df[df['location'].notnull()]
        
        parkings = []
        for _, row in df.iterrows():
            lat, lon = map(float, row['location'].split(','))
            parkings.append({"parkingName": row['parkingName'], "lat": lat, "lon": lon})
        return parkings
    except Exception as error:
        print(f"Error reading CSV file: {error}")
        return []

def find_closest_parkings(place_name, parkings):
    lat, lon = get_coordinates(place_name)
    if lat is None or lon is None:
        return None
    
    distances = []
    for parking in parkings:
        distance = haversine(lat, lon, parking["lat"], parking["lon"])
        distances.append((parking["parkingName"], distance))
    
    # Sort by distance
    distances.sort(key=lambda x: x[1])
    
    # Get the two closest parkings
    closest_parkings = distances[:2]
    return closest_parkings

def fetch_parking_info(cinema_name, file_path):
    parkings = fetch_parkings_from_csv(file_path)
    if parkings:
        closest_parkings = find_closest_parkings(cinema_name, parkings)
        if closest_parkings:
            return [parking for parking, distance in closest_parkings]
        else:
            print(f"No parkings found near {cinema_name}")
            return []
    else:
        print("No parking data found.")
        return []

# Example usage:
place_name = "Kinepolis Brussels"
file_path = "parkingList.csv"
closest_parkings = fetch_parking_info(place_name, file_path)

if closest_parkings:
    print(f"The two closest parkings to {place_name} are:")
    print(closest_parkings)
    for parking in closest_parkings:
        print(parking)
else:
    print("No parking data found.")
