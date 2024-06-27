# scraping_app.py
from flask import Flask, jsonify

from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for all origins during development


@app.route('/scrape', methods=['GET'])
def scrape_data():
    # Perform your web scraping here
    scraped_data = {'message': 'Scraping results here'}
    return jsonify(scraped_data)

if __name__ == '__main__':
    app.run(debug=True)

