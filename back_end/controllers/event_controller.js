const Event = require("../models/event");
const {generateID} = require("../middleware/generateID");

async function handleAddEvent (req,res)

 {
    try {
      const formData = req.body;
  
      const idEvent = generateID();

    
      // Create a new reservation
      const event = await Event.create({
        id : idEvent,
        CreatedAt: new Date(), 
        EndedAt: formData.EndedAt, 
        title: formData.title, 
        description:formData.description,
        adress:formData.adress,
        price:formData.price
       
      });

      return res.status(200).json({ event });
      
    } catch (error) {
      console.error("Error:", error);
      res.status(500).send("Error is occured when handle Add event");
    }
};

module.exports = {handleAddEvent}