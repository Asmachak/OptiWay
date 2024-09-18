// Import the necessary models
const { v4: uuidv4 } = require('uuid');
const Event = require('../models/event');
const Parking = require('../models/parking');
const Reclamation = require('../models/reclamation');
const User = require('../models/user');

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
    const reclamations = await Reclamation.findAll();
    
    // Return reclamations as part of an object, in case you want to add more info later
    res.status(200).send(reclamations);
    
  } catch (error) {
    console.error("Error retrieving reclamations:", error);
    
    // More detailed error response
    res.status(500).json({
      success: false,
      message: "An error occurred while fetching reclamations",
      error: error.message, // Optionally expose error details
    });
  }
}

module.exports = { addReclamation,getAllReclamations };
