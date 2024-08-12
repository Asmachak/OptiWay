const Message = require("../models/message");
const Room = require("../models/room");
const User = require("../models/user");
const { v4: uuidv4 } = require('uuid');

module.exports = function (io) {
  io.on('connection', (socket) => {
    console.log('A user connected:', socket.id);

    // Handle user connection (without registering if not needed)
    socket.on('join_room', async (data) => {
      const { roomId, userId } = data;

      try {
        // Start a transaction
        const result = await sequelize.transaction(async (t) => {
          // Find or create the room

          const room1 = await Room.findByPk(roomId);

          if(room1 == null){
            const room = await Room.create({
              id:roomId,
              
                // Adjust based on your application logic
              },
            );
          }
          

          socket.join(roomId);
          console.log(`${userId} joined room: ${roomId}`);

          // Load chat history
          const messages = await Message.findAll({
            where: { roomId: roomId },
            order: [['createdAt', 'ASC']], // Assuming there's a timestamp column named createdAt
            transaction: t,
          });

          socket.emit('load_messages', messages);
        });
      } catch (err) {
        console.error('Error joining room:', err);
      }
    });

    // Handle sending messages
    socket.on('send_message', async (data) => {
      const { roomId, senderId, message } = data;

      try {
        // Ensure the room exists
        const roomExists = await Room.findOne({ where: { id: roomId } });
        if (!roomExists) {
          console.error('Error: Room does not exist.');
          return;
        }

        const newMessage = await Message.create({
          id: uuidv4(),
          roomId: roomId,
          sender: senderId,
          content: message, // Assuming the content field in your Message model
        });

        io.to(roomId).emit('receive_message', newMessage);
        console.log(`Message sent to room ${roomId}: ${message}`);
      } catch (err) {
        console.error('Error sending message:', err);
      }
    });

    // Handle user disconnection
    socket.on('disconnect', () => {
      console.log('User disconnected:', socket.id);
    });
  });
};
