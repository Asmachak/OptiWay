// notification_controller.js
const { v4: uuidv4 } = require('uuid');
const axios = require('axios');
const { Op } = require('sequelize');
const moment = require('moment-timezone');
const Notification = require('../models/notification'); // Import the Notification model
const Reservation = require('../models/reservation');
const User = require('../models/user');
const Parking = require('../models/parking');
const ReservationParking = require('../models/reservation_parking');

// Function to send notifications to a specific user via Socket.io
function sendNotificationToUser(io, userId, notification) {
    const sockets = io.sockets.sockets;
    for (let [id, socket] of sockets) {
        if (socket.userId === userId) {
            socket.emit('new_notification', notification);
        }
    }
}

// Cron job to schedule reservation notifications
function scheduleReservationNotifications(io) {
    const cron = require('node-cron');

    cron.schedule('* * * * *', async () => {
        console.log('Checking for reservations ending in 15 minutes...');

        try {
            // Calculate the current time and 15 minutes from now, considering the timezone
            const now = moment().utcOffset('+01:00');
            const fifteenMinutesFromNow = moment(now).add(15, 'minutes');
            const sixteenMinutesFromNow = moment(now).add(16, 'minutes');

            console.log(`Now (UTC+1): ${now.format()}`);
            console.log(`15 Minutes From Now (UTC+1): ${fifteenMinutesFromNow.format()}`);

            // Find reservations that end within the next 15 minutes
            const reservations = await Reservation.findAll({
                where: {
                    EndedAt: {
                        [Op.between]: [fifteenMinutesFromNow.toDate(), sixteenMinutesFromNow.toDate()]
                    },
                    state: ['in progress', 'extended']
                },
                include: [
                  {
                    model: User,
                    as: 'user' // Ensure this matches the alias used in the association
                  },
                  {
                    model: ReservationParking,
                    as: 'reservationParking',
                    include: {
                      model: Parking,
                      as: 'parking'
                    }
                  }
                ]
                
            });

            // Send notifications to users whose reservations are ending soon
            for (const reservation of reservations) {
                const user = reservation.user; // The associated user
              console.log(reservation);
                if (user && user.deviceId) {
                    // Customize notification details
                    const title = "Your Reservation Will Expire Soon";
                    const message = `Your reservation will end in ${reservation.reservationParking.parking.parkingName} at ${moment(reservation.EndedAt).tz('Europe/Paris').format('hh:mm A z')}. Please pick up your car or extend your reservation.`;
                    const iconImage = "https://res.cloudinary.com/deceqy9yo/image/upload/f_auto,q_auto/optiway_tcywk3";

                    // Send the notification via OneSignal
                    await axios.post('https://onesignal.com/api/v1/notifications', {
                        app_id: "5d68e5d3-7e31-4a0d-934a-2c9af0f3ce3b",
                        contents: { "en": message },
                        headings: { "en": title },
                        include_player_ids: [user.deviceId],
                        big_picture: iconImage
                    }, {
                        headers: {
                            'Authorization': `Basic ZjcxZWU5YjQtNTRmYi00MGViLThkMTQtM2Q0MDcyNmU0ODMx`,
                            'Content-Type': 'application/json'
                        }
                    });

                    console.log(`Notification sent to user ${user.id} for reservation ${reservation.id}`);

                    // Create a notification record in the database
                    const notification = await Notification.create({
                        id: uuidv4(),
                        iduser: user.id,
                        title: title,
                        description: message,
                    });

                    // Emit the notification to the specific user via Socket.io
                    sendNotificationToUser(io, user.id, notification);
                } else {
                    console.log(`No device ID for user ${user.id}. Notification not sent.`);
                }
            }
        } catch (error) {
            console.error('Error checking reservations or sending notifications:', error);
        }
    });
}

async function getNotifications(req, res) {
  try {
    const { id } = req.params;

    // Find the reservation by its ID
    const notifications = await Notification.findAll({
      where: {
       iduser:id
      }
    });
    // Send a success response
    res.status(200).send(notifications);
  } catch (error) {
    console.error("Error occurred when geting notifications:", error);
    res.status(500).send("Error occurred when geting notifications: " + error.message);
  }
}


module.exports = {
    scheduleReservationNotifications,
    sendNotificationToUser,
    getNotifications
};
