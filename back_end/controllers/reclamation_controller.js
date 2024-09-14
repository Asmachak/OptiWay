// Import the necessary models
const { Reclamation, User, Organizer, Event, Parking } = require('../models'); // Adjust the path to your models

async function addReclamation(req, res) {
  try {
    // Extract information from the request body
    const { reclaimerId,targetId} = req.params
    const { targetType, title } = req.body;

    // Validate that the essential fields are provided
    if (!reclaimerId || !targetType || !targetId || !title) {
      return res.status(400).json({ message: 'Missing required fields' });
    }

    // Determine the target type (user, event, or parking)
    let targetField;
    switch (targetType) {
      case 'user':
        targetField = 'targetUserId';
        // Check if the target user exists
        const user = await User.findByPk(targetId);
        if (!user) {
          return res.status(404).json({ message: 'Target user not found' });
        }
        break;
      case 'event':
        targetField = 'targetEventId';
        // Check if the target event exists
        const event = await Event.findByPk(targetId);
        if (!event) {
          return res.status(404).json({ message: 'Target event not found' });
        }
        break;
      case 'parking':
        targetField = 'targetParkingId';
        // Check if the target parking exists
        const parking = await Parking.findByPk(targetId);
        if (!parking) {
          return res.status(404).json({ message: 'Target parking not found' });
        }
        break;
      default:
        return res.status(400).json({ message: 'Invalid targetType' });
    }

    // Create a new reclamation
    const newReclamation = await Reclamation.create({
      title: title,
      targetType: targetType,
      reclaimerId: reclaimerId,
      [targetField]: targetId  // Dynamically set the target based on the type
    });

    // Return the newly created reclamation
    return res.status(201).json({ message: 'Reclamation added successfully', reclamation: newReclamation });

  } catch (error) {
    console.error('Error adding reclamation:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
}

module.exports = { addReclamation };
