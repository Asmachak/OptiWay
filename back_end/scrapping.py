import requests
from bs4 import BeautifulSoup
import json
import uuid

def scrape_website(url):
    try:
        # Make an HTTP request to the website
        response = requests.get(url)
        response.raise_for_status()  # Check if the request was successful

        # Load the HTML into BeautifulSoup
        soup = BeautifulSoup(response.content, 'html.parser')

        # List to hold the scraped movie data
        movie_data = []

        # Find all article elements with the class 'stk movies-stk'
        articles = soup.find_all('article', class_='stk movies-stk')
        for article in articles:
            # Generate a unique ID for each movie
            movie_id = str(uuid.uuid4())

            # Extract the image URL
            img = article.find('img')
            img_url = img.get('data-src') if img else None

            # Extract the movie title
            title = article.find('h3', class_='stk-title').text.strip()

            # Extract the genre
            genres = article.find_all('a', itemprop='genre')
            genre_list = [genre.text for genre in genres]
            genre_string = ', '.join(genre_list) if genre_list else ''

            # Extract the rating
            rating = article.find('span', class_='stk-rating loaded')
            rating_value = rating.get('data-star') if rating else None

            # Extract the director(s)
            directors = article.find_all('span', class_='stk-directedBy')
            director_list = [director.text.replace('Directed by:', '').strip() for director in directors]

            # Extract the starring actors
            stars = article.find_all('span', class_='stk-staring')
            star_list = [star.text.replace('With:', '').strip() for star in stars]

            # Extract the description
            description = article.find('span', class_='stk-description')
            description_text = description.text if description else None

            # Extract the cinema locations and timings
            cinema_list = []
            cinemas = article.find('ul', class_='stk-place')
            if cinemas:
                for li in cinemas.find_all('li'):
                    cinema_name = li.find('a').text
                    cinema_url = li.find('a')['href']
                    #cinema_timings = get_cinema_timings(cinema_url)
                    cinema_list.append({
                        'name': cinema_name,
                        #'timings': cinema_timings
                    })

            # Append the movie data to the list
            movie_data.append({
                'id': movie_id,
                'title': title,
                'image_url': img_url,
                'genres': genre_string,
                'rating': rating_value,
                'directors': director_list,
                'stars': star_list,
                'description': description_text,
                'cinemas': cinema_list
            })

        return movie_data

    except requests.exceptions.RequestException as e:
        print(f"Error scraping the website: {e}")
        return []


# Function to scrape cinema timings from a specific cinema URL
def get_cinema_timings(cinema_url):
    try:
        response = requests.get('https://www.cinenews.be' + cinema_url)
        response.raise_for_status()  # Check if the request was successful

        soup = BeautifulSoup(response.content, 'html.parser')
        timings = []

        # Find all timings for the cinema
        showtimes = soup.find_all('li', {'data-st-id': True})
        for showtime in showtimes:
            timing = showtime.find('span', class_='t').text.strip()
            version = showtime.find('span', class_='v').text.strip()
            timings.append({'time': timing, 'version': version})

        return timings

    except requests.exceptions.RequestException as e:
        print(f"Error scraping cinema timings: {e}")
        return []

# URLs to scrape
urls = [
    'https://www.cinenews.be/en/cinema/program/region/brussels/?startrow=1',
    'https://www.cinenews.be/en/cinema/program/region/brussels/?startrow=25',
    "https://www.cinenews.be/en/cinema/program/region/brussels/?startrow=49",
    "https://www.cinenews.be/en/cinema/program/region/brussels/?startrow=73",
    "https://www.cinenews.be/en/cinema/program/region/brussels/?startrow=97",
    "https://www.cinenews.be/en/cinema/program/region/brussels/?startrow=121",
    "https://www.cinenews.be/en/cinema/program/region/brussels/?startrow=145",
    "https://www.cinenews.be/en/cinema/program/region/brussels/?startrow=169"

]

# List to hold all movie data
all_movie_data = []

# Iterate through each URL and scrape movie data
for url in urls:
    movie_data = scrape_website(url)
    all_movie_data.extend(movie_data)

# Convert the list of movie data to JSON format
json_data = json.dumps(all_movie_data, indent=2)

# Write the JSON data to a file
with open('movie_data.json', 'w') as json_file:
    json_file.write(json_data)

# Print the JSON data
print(json_data)
