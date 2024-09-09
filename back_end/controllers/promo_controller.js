const Promotion = require("../models/promotion");
const Notification = require("../models/notification");
const User = require("../models/user");
const Event = require("../models/event"); // Import the Event model
const { v4: uuidv4 } = require('uuid');
const axios = require('axios');
const { where } = require("sequelize");
const { Op } = require('sequelize');

async function handleAddPromo(req, res) {
    try {
        const { body: formData, params } = req;
        const { idevent } = params;

        const idPromo = uuidv4();

        // Check if an active promotion already exists for the event
        const existingPromo = await Promotion.findOne({
            where: {
                idevent,
                state: "active",
            }
        });

        // If an existing active promo is found, return an error response
        if (existingPromo) {
            return res.status(409).send("Can't add a promo to an existing active promo.");
        }

        // Fetch the event details
        const event = await Event.findByPk(idevent);

        // If event not found, return an error response
        if (!event) {
            return res.status(404).send("Event not found.");
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
            idevent
        });

        // Notification details
        const title = "New Promotion Added!";
        const message = `Promotion: ${promo.title} - ${promo.description}`;
        const iconImage = "https://st.depositphotos.com/1186248/4216/i/950/depositphotos_42167223-stock-photo-promo.jpg"; // Replace with your actual image URL

        // Fetch all users with a deviceId
        const users = await User.findAll({ where: { deviceId: { [Op.ne]: null } } });
        const playerIds = users.map(user => user.deviceId);

        // Send notifications to all users using OneSignal
        if (playerIds.length > 0) {
            await axios.post('https://onesignal.com/api/v1/notifications', {
                app_id: "5d68e5d3-7e31-4a0d-934a-2c9af0f3ce3b", // Replace with your OneSignal App ID
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

        // Store notification in the Notification table for each user
        const notifications = users.map(user => ({
            id: uuidv4(),
            iduser: user.id,
            title,
            description: message,
        }));
        await Notification.bulkCreate(notifications);

        // Include the event details in the response
        const promotion = await Promotion.findOne({
            where: { id: promo.id },
            include: { model: Event }
        });
        // const eventPromo = await Event.findOne({
        //     where: { id: idevent },
        //     include: { model: Promotion }
        // });
        return res.status(200).json(promotion);
    } catch (error) {
        console.error("Error:", error);
        return res.status(500).send("An error occurred while handling Add Promo.");
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
