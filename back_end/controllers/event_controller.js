const Event = require("../models/event");
const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');
const { Op } = require('sequelize'); 
const {handleImageUploadAsync} = require('../middleware/cloudinary');


async function handleAddEvent(req, res) {
  try {
    const imageUrl = await handleImageUploadAsync(req, res);
    console.log("Image URL:", imageUrl);

    const {
      title = "",
      description = "",
      endedAt,
      unit_price = "0.0",
      capacity = "0",
      genres = null,
      rating = "0.0",
      type = null,
      place = null,
      additional_info = "{}",
    } = req.body;
    const idOrganiser = req.params.idOrganiser;

    // Parse numeric values safely
    const parsedUnitPrice = parseFloat(unit_price);
    const parsedCapacity = parseInt(capacity);
    const parsedRating = parseFloat(rating);

    const event = await Event.create({
      id: uuidv4(),
      title,
      description,
      image_url: imageUrl,
      createdAt: new Date(),
      endedAt: endedAt ? new Date(endedAt) : new Date(),
      unit_price: isNaN(parsedUnitPrice) ? 0.0 : parsedUnitPrice,
      capacity: isNaN(parsedCapacity) ? 0 : parsedCapacity,
      genres,
      rating: isNaN(parsedRating) ? 0.0 : parsedRating,
      type,
      place,
      additional_info: JSON.parse(additional_info),
      idOrganiser,
    });

    return res.status(200).send({
      id: event.id,
      title: event.title,
      description: event.description,
      image_url: event.image_url,
      createdAt: event.createdAt,
      endedAt: event.endedAt,
      unit_price: event.unit_price,
      capacity: event.capacity,
      genres: event.genres,
      rating: event.rating,
      type: event.type,
      place: event.place,
      additional_info: event.additional_info,
      idOrganiser: event.idOrganiser,
      parkings: [],
    });
  } catch (error) {
    console.error("Error:", error);
    return res.status(500).send({ error: "Error occurred while handling Add Event", details: error.message });
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
          id: eventData.id ,
          title: eventData.title,
          createdAt : eventData.createdAt,
          description: eventData.description || " ",
          capacity: eventData.capacity || 100,
          endedAt: eventData.EndedAt || new Date(),
          unit_price:eventData.price || 6,
          rating:eventData.rating || '',
          image_url:eventData.image_url || '',
          genres:eventData.genres || '',
          type:"movie"
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

async function deleteEvent(req, res) {
  try {
    const eventId = req.params.eventId;
  
    // Check if the event exists
    const existingEvent = await Event.findOne({ where: { id: eventId } });
  
    if (!existingEvent) {
      return res.status(404).json({ error: 'Event not found' });
    }
  
    // Delete the event
    await Event.destroy({
      where: { id: eventId }
    });
  
    // Return success response
    return res.status(200).json({ message: "Event deleted successfully" });
    
  } catch (error) {
    console.error("Error:", error);
    return res.status(500).send("Error occurred while deleting the event.");
  }
};

async function getEvents(req, res) {
  try {
    const { idOrganiser } = req.params;

    // Find the reservation by its ID
    const events = await Event.findAll({
      where: {
        idOrganiser:idOrganiser
      }
    });
    // Send a success response
    console.log(typeof events);
    res.status(200).send(events);
  } catch (error) {
    console.error("Error occurred when geting events:", error);
    res.status(500).send("Error occurred when geting events: " + error.message);
  }
}

async function updateEvent (req, res) {
  try {
    const eventId = req.params.eventId;

    const existingEvent = await Event.findByPk(eventId);

    if (!existingEvent) {
      return res.status(404).json({ error: 'Event not found' });
    }

    const updatedEventData = req.body;

    console.log(updatedEventData);

    console.log("exist ",existingEvent);

   await existingEvent.update({
      title: updatedEventData.title || existingEvent.title,
      description: updatedEventData.description || existingEvent.description,
      capacity: updatedEventData.capacity || existingEvent.capacity,
      place: updatedEventData.place || existingEvent.place,
      image_url: updatedEventData.image_url || existingEvent.image_url,
      createdAt: updatedEventData.createdAt || existingEvent.createdAt,
      endedAt: updatedEventData.endedAt || existingEvent.endedAt,
      unit_price: updatedEventData.unit_price || existingEvent.unit_price,
      genres: updatedEventData.genres || existingEvent.genres,
      type: updatedEventData.type || existingEvent.type,
      additional_info: updatedEventData.additional_info || existingEvent.additional_info,
    });

    const event = await Event.findByPk(eventId);
    return res.status(200).send(event);

  } catch (error) {
    // Handle errors
    console.error(error);
    res.status(500).json({ success: false, error: 'Something went wrong in updateEvent' });
  }
};

module.exports = { handleAddEvent, insertDataFromJsonToDb,deleteEvent,getEvents,updateEvent };
