const Promotion = require("../models/promotion");
const Notification = require("../models/notification");
const User = require("../models/user");
const Event = require("../models/event"); // Import the Event model
const { v4: uuidv4 } = require('uuid');
const axios = require('axios');
const { where } = require("sequelize");

async function handleAddPromo(req, res) {
    try {
        const formData = req.body;
        const params = req.params;

        const idPromo = uuidv4();

        const check = await Promotion.findAll({
            where:{
                idevent:params.idevent,
                state: "active",
            }
        });

        if(check) {
            return res.status(404).send("Cant't add promo to an existing promo");
        }

        // Create a new promotion
        const promo = await Promotion.create({
            id: idPromo,
            title: formData.title || "",
            description: formData.description || "",
            address: formData.address || "",
            ticketNumber: formData.ticketNumber || 0,
            percentageEvent: formData.percentageEvent || 0,
            percentageParking: formData.percentageParking || 0,
            createdAt: new Date(),
            EndedAt: formData.EndedAt || new Date(),
            state: "active",
            idevent: params.idevent  
        });

        // Fetch the event details
        const event = await Event.findByPk(params.idevent);

        // If event not found, return an error response
        if (!event) {
            return res.status(404).send("Event not found");
        }

        // Notification details
        const title = "New Promotion Added!";
        const message = `Promotion: ${promo.title} - ${promo.description}`;
        const iconImage = "https://st.depositphotos.com/1186248/4216/i/950/depositphotos_42167223-stock-photo-promo.jpg"; // Replace with your actual image URL

        // Fetch all users
        const users = await User.findAll();
        const playerIds = users.map(user => user.deviceId).filter(id => !!id); // Get all playerIds that are not null

        // Send notifications to all users using OneSignal
        if (playerIds.length > 0) {
            await axios.post('https://onesignal.com/api/v1/notifications', {
                app_id:  "5d68e5d3-7e31-4a0d-934a-2c9af0f3ce3b", // Replace with your OneSignal App ID
                contents: { "en": message },
                headings: { "en": title },
                include_player_ids: playerIds,
                big_picture: iconImage
            }, {
                headers: {
                    'Authorization': `Basic ZjcxZWU5YjQtNTRmYi00MGViLThkMTQtM2Q0MDcyNmU0ODMx`, // Replace with your OneSignal REST API Key
                    'Content-Type': 'application/json'
                }
            });
        }

        // Store notification in Notification table for each user
        for (const user of users) {
            if (user.deviceId) {
                await Notification.create({
                    id: uuidv4(),
                    iduser: user.id,
                    title: title,
                    description: message,
                });
            }
        }

        const promotion = await Promotion.findOne({
            where: { id: promo.id },
            include: {
                model: Event
            }
        });
        

        // Include the event details in the response
        return res.status(200).send(promotion);
    } catch (error) {
        console.error("Error:", error);
        res.status(500).send("Error occurred when handling Add promo");
    }
}


async function getPromoByEventId(req, res) {
    try {
        const params = req.params;

        const promo = await Promotion.findOne({
            where : {
                idevent : params.idevent,
                state:'active'
            }
        });

        console.log(promo);

        if(promo) res.status(200).send(promo);
        else res.status(200).send({});

        


    } catch (error) {
        console.error("Error:", error);
        res.status(500).send("Error occurred when handling Add promo");
    }
    
}

async function getPromoList(req, res) {
    try {
        const params = req.params;

        const promo = await Promotion.findAll({
            where : {
            state:'active'
            },include:{
                model:Event
            }
        });

        console.log(promo);

        res.status(200).send(promo);


    } catch (error) {
        console.error("Error:", error);
        res.status(500).send("Error occurred when handling Add promo");
    }
    
}

async function DeletePromo(req, res) {
    try {
        const params = req.params;

        const promo = await Promotion.findByPk(params.id);

        if(promo) await promo.destroy();

        console.log(promo);

        res.status(200).send("Promo deleted successfully.");


    } catch (error) {
        console.error("Error:", error);
        res.status(500).send("Error occurred when handling Add promo");
    }
    
}

module.exports = { handleAddPromo,getPromoByEventId,getPromoList,DeletePromo };
