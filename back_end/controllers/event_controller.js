const Event = require("../models/event");
const { generateID } = require("../middleware/generateID");
const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');
const { Op } = require('sequelize'); // Import Sequelize operators if needed

async function handleAddEvent(req, res) {
  try {
    const formData = req.body;

    const idEvent = generateID();

    // Create a new event
    const event = await Event.create({
      id: idEvent,
      createdAt: new Date(),
      EndedAt: formData.EndedAt ||new Date(),
      title: formData.title ||"",
      description: formData.description ||"",
      address: formData.address ||"",
      price: formData.price ||""
    });

    return res.status(200).json({ event });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error occurred when handling Add event");
  }
}

async function insertDataFromJsonToDb() {
  try {
    // Load JSON data
    const data = JSON.parse(fs.readFileSync(path.join(__dirname, '../movie_data.json'), 'utf-8'));

    // Iterate over each event in the JSON data and insert it into the database
    for (let eventData of data) {
      // Check if the event already exists to avoid duplicate entries
      let existingEvent = await Event.findOne({
        where: {
          [Op.or]: [{ id: eventData.id }, { title: eventData.title }]
        }
      });

      if (!existingEvent) {
        // Create a new event record
        await Event.create({
          id: eventData.id || uuidv4(),
          title: eventData.title,
          createdAt : eventData.createdAt,
          description: eventData.description || " ",
          capacity: eventData.capacity || 100,
          EndedAt: eventData.EndedAt || new Date(),
          price:eventData.price || 20,
          rating:eventData.rating || '',
          image_url:eventData.image_url || '',
          genres:eventData.genres || '',



          // Add other fields as necessary
        });
        console.log(`Event ${eventData.title} inserted successfully.`);
      } else {
        console.log(`Event ${eventData.title} already exists in the database.`);
      }
    }

    console.log("Data insertion from JSON to DB completed successfully.");
  } catch (error) {
    console.error("Error inserting data from JSON to DB:", error);
  }
}

module.exports = { handleAddEvent, insertDataFromJsonToDb };
