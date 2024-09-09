const Event = require("../models/event");
const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');
const { Op } = require('sequelize'); 
const {handleImageUploadAsync} = require('../middleware/cloudinary');
const ReservationEventParking = require("../models/reservation_event_parking");
const Parking = require("../models/parking");
const Promotion = require("../models/promotion");

function fixInvalidJsonString(invalidJsonString) {
  // Add double quotes around keys and string values
  const fixedJsonString = invalidJsonString
    .replace(/([{,])\s*([^{}\[\],:]+)\s*:/g, '$1"$2":') // Add quotes around keys
    .replace(/:\s*([^{}\[\],:]+)\s*([,}])/g, ': "$1"$2'); // Add quotes around string values

  return fixedJsonString;
}


async function handleAddEvent(req, res) {
  try {
    const imageUrl = await handleImageUploadAsync(req, res);
    console.log("Image URL:", imageUrl);
    const parkingList = [];

    const {
      image_url, // Provided by client but overwritten by uploaded image URL
      title,
      description,
      endedAt,
      unit_price,
      capacity,
      genres,
      rating,
      type,
      place,
      additional_info,
      parkings // Array of parking objects (or stringified JSON)
    } = req.body;

    const idOrganiser = req.params.idOrganiser;

    // Safely parse numeric values
    const parsedUnitPrice = parseFloat(unit_price);
    const parsedCapacity = parseInt(capacity);
    const parsedRating = parseFloat(rating);

    // Log the raw value of additional_info to check its format
    console.log("Raw additional_info:", additional_info);
    console.log("Parkings (before parsing):", typeof parkings, parkings);


    // Ensure additional_info is a valid JSON object or null
    let parsedAdditionalInfo = null;
    if (typeof additional_info === 'string') {
      try {
        parsedAdditionalInfo = JSON.parse(additional_info); // Parse if it's a valid JSON string
      } catch (error) {
        console.warn('Invalid JSON format for additional_info, storing as null:', error);
        parsedAdditionalInfo = null; // Set to null if parsing fails
      }
    } else if (typeof additional_info === 'object' && additional_info !== null) {
      parsedAdditionalInfo = additional_info; // If already an object, store as is
    }

    // Parse parkings - it could be either a stringified JSON or a direct array
    let parsedParkings = [];

    const fixedParkings = fixInvalidJsonString(parkings);
    if (typeof parkings === 'string') {
      try {
        parsedParkings = JSON.parse(fixedParkings); // Attempt to parse stringified JSON
      } catch (error) {
        console.warn('Invalid JSON format for parkings, treating as empty array:', error);
        parsedParkings = [];
      }
    } else if (Array.isArray(parkings)) {
      parsedParkings = parkings; // Already an array, no need to parse
    } else {
      console.warn('Invalid format for parkings, expected string or array.');
    }

    console.log("Parkings (after parsing):", parsedParkings);

    // Create the event object in the database
    const event = await Event.create({
      id: uuidv4(),
      title,
      description,
      image_url: imageUrl, // Use the uploaded image URL
      createdAt: new Date(),
      endedAt: endedAt ? new Date(endedAt) : new Date(),
      unit_price: isNaN(parsedUnitPrice) ? 0.0 : parsedUnitPrice,
      capacity: isNaN(parsedCapacity) ? 0 : parsedCapacity,
      genres,
      rating: isNaN(parsedRating) ? 0.0 : parsedRating,
      type,
      place,
      additional_info: parsedAdditionalInfo, // Store the parsed info here
      idOrganiser,
    });

    // Loop through the parsedParkings array and create ReservationEventParking for each parking entry
    for (const parkingData of parsedParkings) {
      console.log("Processing parking data:", parkingData);

      // Ensure that parkingData contains valid fields
      if (parkingData && parkingData.idparking && parkingData.nbre_place && parkingData.tarif) {
        const { idparking, nbre_place, tarif } = parkingData;

        // Fetch parking by primary key
        const parking = await Parking.findByPk(idparking);

        if (parking) {
          await ReservationEventParking.create({
            id: uuidv4(),
            idevent: event.id,
            idparking,
            nbre_place: parseInt(nbre_place),
            tarif: parseFloat(tarif),
            state: 'in progress'
          });

          parkingList.push({
            idparking,
            nbre_place,
            tarif,
            parking: {
              id: parking.id,
              name: parking.name, // Assuming parking has a 'name' field
              location: parking.location // Assuming parking has a 'location' field
            }
          });
        } else {
          console.warn(`Parking with id ${idparking} not found`);
        }
      } else {
        console.warn("Invalid or missing fields in parking data:", parkingData);
      }
    }

    // Return a successful response with the event data and parking list
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
      parkings: parkingList // Return the list of parkings
    });

  } catch (error) {
    console.error("Error:", error);
    return res.status(500).send({
      error: "Error occurred while handling Add Event",
      details: error.message,
    });
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
    
    // Log the received params to ensure eventId is being passed correctly
    console.log('Received eventId:', eventId);
    
    if (!eventId) {
      return res.status(400).json({ error: 'Event ID is required' });
    }
  
    // Check if the event exists
    const existingEvent = await Event.findOne({ where: { id: eventId } });
  
    if (!existingEvent) {
      return res.status(404).json({ error: 'Event not found' });
    }
  
    // Delete the event
    await Event.destroy({ where: { id: eventId } });
  
    // Return success response
    return res.status(200).send("Event deleted successfully");
    
  } catch (error) {
    console.error("Error:", error);
    return res.status(500).send("Error occurred while deleting the event.");
  }
}


async function getEvents(req, res) {
  try {
    const { idOrganiser } = req.params;

    // Find all events by organiser ID
    const events = await Event.findAll({
      where: {
        idOrganiser: idOrganiser
      }
    });

    // Check if no events found
    if (!events || events.length === 0) {
      return res.status(404).send({ message: "No events found for this organiser" });
    }

    // Array to hold the final result
    const result = [];

    // Loop through each event and fetch associated parking and promotions
    for (const event of events) {
      // Get all parking reservations for the event
      const reservations = await ReservationEventParking.findAll({
        where: { idevent: event.id }
      });

      // Fetch parking details for each reservation
      const parkings = [];
      for (const reservation of reservations) {
        const parking = await Parking.findByPk(reservation.idparking);
        if (parking) {
          parkings.push({
            id: parking.id,
            nbre_place: reservation.nbre_place,
            tarif: reservation.tarif,
            state: reservation.state,
          });
        }
      }

      // Fetch the active promotion for the event
      const promotion = await Promotion.findOne({
        where: {
          idevent: event.id,
          state: "active"
        }
      });

      // Add event details to the result array
      result.push({
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
        parkings: parkings, // Add list of parkings
        promotion: promotion ? 
         promotion
         : null // Add promotion if available, else null
      });
    }

    // Send the result
    res.status(200).json(result);
  } catch (error) {
    console.error("Error occurred when getting events:", error);
    res.status(500).send("Error occurred when getting events: " + error.message);
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
