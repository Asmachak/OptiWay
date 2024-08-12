const { getMessaging } = require('firebase-admin/messaging');
const User = require('../models/user');

async function sendRealTimeNotification(
    receiverId,
    notification,
    emitToSocket = true,
    sendPushNotification = true
  ) {
    try {
      const user = await User.findById(receiverId);
      if (!user) return;
      if (!user?.settings?.notifications) return;
          console.log(receiverId);
      if (emitToSocket) {
        global.io
          .to(`notifications-${user._id.toString()}`)
          .emit('notification', notification);
      }
  
      console.log(user.email);
      console.log(user.deviceIds);
  
      if (sendPushNotification) {
        if (user.deviceIds && user.deviceIds.length > 0) {
          const invalidRegistrationTokens = [];
  
          const sendPromises = user.deviceIds.map(async (deviceId) => {
            const message = {
              notification: {
                title: notification.title,
                body: notification.description,
              },
              token: deviceId,
              android: {
                priority: 'high',
              },
              apns: {
                payload: {
                  aps: {
                    contentAvailable: true,
                    priority: 'high',
                  },
                },
              },
             
            };
            console.log(message);
  
            try {
              const response = await getMessaging(global.firebaseApp).send(
                message
              );
              console.log('Successfully sent message:', response);
            } catch (error) {
              invalidRegistrationTokens.push(deviceId);
              console.log(
                'deviceId error in sendRealTimeNotification ',
                deviceId
              );
            }
          });
  
          // Wait for all sendPromises to complete before logging invalidRegistrationTokens
          await Promise.all(sendPromises);
  
          if (invalidRegistrationTokens.length > 0) {
            user.deviceIds = user.deviceIds.filter(
              (deviceId) => !invalidRegistrationTokens.includes(deviceId)
            );
            await user.save();
          }
        }
      }
    } catch (err) {
      console.log('error in sendRealTimeNotification');
    }
  }
  