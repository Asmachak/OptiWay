// Import the necessary models
const { v4: uuidv4 } = require('uuid');
const Event = require('../models/event');
const Parking = require('../models/parking');
const Reclamation = require('../models/reclamation');
const User = require('../models/user');
const Organiser = require('../models/organiser');

async function addReclamation(req, res) {
  try {
    // Extract parameters from URL
    const { reclaimerId, targetId } = req.params;
    const { targetType, title } = req.body;

    // Validate that the essential fields are provided
    if (!reclaimerId || !targetType || !targetId || !title) {
      return res.status(400).json({ message: 'Missing required fields' });
    }

    // Initialize an object to store the field to set
    const newReclamationData = {
      id: uuidv4(),
      title,
      targetType,
      reclaimerId
    };

    // Determine the target type (user, event, or parking) and set the correct target field
    switch (targetType) {
      case 'user':
        // Check if the target user exists
        const user = await User.findByPk(targetId);
        if (!user) {
          return res.status(404).json({ message: 'Target user not found' });
        }
        newReclamationData.iduser = targetId;  // Set the iduser field
        newReclamationData.idorganiser = reclaimerId;
        break;

      case 'event':
        // Check if the target event exists
        const event = await Event.findByPk(targetId);
        if (!event) {
          return res.status(404).json({ message: 'Target event not found' });
        }
        newReclamationData.idevent = targetId;  // Set the idevent field
        newReclamationData.iduser = reclaimerId;

        break;

      case 'parking':
        // Check if the target parking exists
        const parking = await Parking.findByPk(targetId);
        if (!parking) {
          return res.status(404).json({ message: 'Target parking not found' });
        }
        newReclamationData.idparking = targetId;  // Set the idparking field
        newReclamationData.iduser = reclaimerId;

        break;

      default:
        return res.status(400).json({ message: 'Invalid targetType' });
    }

    // Create a new reclamation with the appropriate target field
    const newReclamation = await Reclamation.create(newReclamationData);

    // Return the newly created reclamation
    return res.status(201).send(newReclamation);

  } catch (error) {
    console.error('Error adding reclamation:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
}

async function getAllReclamations(req, res) {
  try {
    // Step 1: Fetch all reclamations without associations
    const reclamations = await Reclamation.findAll({
      attributes: ['id', 'title', 'targetType', 'idevent', 'idparking', 'idorganiser', 'iduser'],
    });

    // Step 2: Loop over each reclamation and fetch associated data manually
    const result = await Promise.all(
      reclamations.map(async (reclamation) => {
        // Fetch username by user ID
        let userName = null;
        if (reclamation.iduser) {
          const user = await User.findByPk(reclamation.iduser, {
            attributes: ['name'],
          });
          userName = user ? user.name : null;
        }

        // Fetch parking name by parking ID
        let parkingName = null;
        if (reclamation.idparking) {
          const parking = await Parking.findByPk(reclamation.idparking, {
            attributes: ['parkingName'],
          });
          parkingName = parking ? parking.parkingName : null;
        }

        // Fetch organiser name by organiser ID
        let organiserName = null;
        if (reclamation.idorganiser) {
          const organiser = await Organiser.findByPk(reclamation.idorganiser, {
            attributes: ['name'],
          });
          organiserName = organiser ? organiser.name : null;
        }

        // Fetch event name by event ID
        let eventName = null;
        if (reclamation.idevent) {
          const event = await Event.findByPk(reclamation.idevent, {
            attributes: ['name'],
          });
          eventName = event ? event.name : null;
        }

        // Step 3: Attach the fetched names to the reclamation object
        return {
          id: reclamation.id,
          title: reclamation.title,
          targetType: reclamation.targetType,
          parkingName,
          userName,
          organiserName,
          eventName,
        };
      })
    );

    // Step 4: Send the final response
    res.status(200).send(
      result
    );
  } catch (error) {
    console.error("Error retrieving reclamations:", error);

    res.status(500).json({
      success: false,
      message: "An error occurred while fetching reclamations",
      error: error.message,
    });
  }
}


module.exports = { addReclamation,getAllReclamations };
