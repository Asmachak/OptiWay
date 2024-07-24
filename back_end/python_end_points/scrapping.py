import requests
from bs4 import BeautifulSoup
import json
import uuid
import random

def generate_random_timings(num_timings=3):
    timings = []
    for _ in range(num_timings):
        timing = f"{random.randint(10, 22)}:{random.choice(['00', '15', '30', '45'])}"
        version = random.choice(['2D', '3D', 'IMAX'])
        timings.append({'time': timing, 'version': version})
    return timings

def scrape_nested_urls(base_url, urls):
    scraped_data = []
    for url in urls:
        try:
            full_url = f"{base_url}{url}"
            response = requests.get(full_url)
            response.raise_for_status()
            soup = BeautifulSoup(response.content, 'html.parser')

            director = soup.select_one("span[itemprop='director'] a").text if soup.select_one("span[itemprop='director'] a") else None
            release_date = soup.select_one("span[itemprop='datePublished']").text if soup.select_one("span[itemprop='datePublished']") else None
            genre = soup.select_one("div[data-tabup='infos'] a[href*='genre']").text if soup.select_one("div[data-tabup='infos'] a[href*='genre']") else None
            country = soup.select_one("span:contains('Country :')").find_next_sibling().text.strip() if soup.select_one("span:contains('Country :')") else None
            original_language = soup.select_one("span:contains('Original language:')").find_next_sibling().text.strip() if soup.select_one("span:contains('Original language:')") else None


            additional_info = {
                'director': director,
                'release_date': release_date,
                'genre': genre,
                'country': country,
                'original_language': original_language
            }


            scraped_data.append(additional_info)

        except requests.exceptions.RequestException as e:
            print(f"Error scraping nested URL {url}: {e}")

    return scraped_data

def scrape_website(urls, base_url):
    try:
        movie_dict = {}

        for url in urls:
            response = requests.get(url)
            response.raise_for_status()
            soup = BeautifulSoup(response.content, 'html.parser')

            articles = soup.find_all('article', class_='stk movies-stk')
            for article in articles:
                title = article.find('h3', class_='stk-title').text.strip()
                existing_movie_id = next((movie_id for movie_id, movie_data in movie_dict.items() if movie_data['title'] == title), None)
                details_url = article.find('a')['href']
                print(details_url)

                # Fetch additional info
                additional_info = scrape_nested_urls(base_url, [details_url])

                if existing_movie_id:
                    cinemas = article.find('ul', class_='stk-place')
                    if cinemas:
                        for li in cinemas.find_all('li'):
                            cinema_name = li.find('a').text
                            place_name = f"cinema {cinema_name} Bruxelle"

                            closest_parkings = fetch_parking_info(place_name, "parkingList.csv")
                            timings = generate_random_timings()
                            existing_movie = movie_dict[existing_movie_id]

                            if cinema_name not in [cinema['name'] for cinema in existing_movie['cinemas']]:
                                existing_movie['cinemas'].append({
                                    'name': cinema_name,
                                    'timings': timings,
                                    'parkings': closest_parkings,
                                })
                                existing_movie['parkings'] = list(set(existing_movie['parkings']) | set([parking[0] for parking in closest_parkings]))

                else:
                    movie_id = str(uuid.uuid4())
                    img = article.find('img')
                    img_url = img.get('data-src') if img else None

                    genres = article.find_all('a', itemprop='genre')
                    genre_list = [genre.text for genre in genres]
                    genre_string = ', '.join(genre_list) if genre_list else ''

                    random_value = random.uniform(1, 5)
                    rating_value = round(random_value * 2) / 2

                    directors = article.find_all('span', class_='stk-directedBy')
                    director_list = [director.text.replace('Directed by:', '').strip() for director in directors]

                    stars = article.find_all('span', class_='stk-staring')
                    star_list = [star.text.replace('With:', '').strip() for star in stars]

                    description = article.find('span', class_='stk-description')
                    description_text = description.text if description else None

                    cinema_list = []
                    parking_set = set()

                    cinemas = article.find('ul', class_='stk-place')
                    if cinemas:
                        for li in cinemas.find_all('li'):
                            cinema_name = li.find('a').text
                            cinema_url = li.find('a')['href']
                            place_name = f"cinema {cinema_name} Bruxelle"

                            closest_parkings = fetch_parking_info(place_name, "parkingList.csv")
                            timings = generate_random_timings()

                            cinema_list.append({
                                'name': cinema_name,
                                'timings': timings,
                                'parkings': closest_parkings,
                            })
                            parking_set.update([parking[0] for parking in closest_parkings])

                    movie_dict[movie_id] = {
                        'id': movie_id,
                        'title': title,
                        'image_url': img_url,
                        'genres': genre_string,
                        'rating': rating_value,
                        'directors': director_list,
                        'stars': star_list,
                        'description': description_text,
                        'cinemas': cinema_list,
                        'parkings': list(parking_set),
                         'additional_info': additional_info[0]

                    }

        return list(movie_dict.values())

    except requests.exceptions.RequestException as e:
        print(f"Error scraping the website: {e}")
        return []

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

base_url = 'https://www.cinenews.be'

all_movie_data = scrape_website(urls, base_url)
json_data = json.dumps(all_movie_data, indent=2)

with open('movie_data.json', 'w') as json_file:
    json_file.write(json_data)

print(json_data)
