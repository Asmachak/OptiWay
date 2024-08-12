const cron = require('node-cron');
const Reservation = require('../models/reservation'); // Adjust the import as needed

cron.schedule('* * * * *', async () => {
  const now = new Date();
  const upcomingReservations = await Reservation.findAll({
    where: {
        EndedAt: {
        [Op.between]: [now, new Date(now.getTime() + 15 * 60 * 1000)],
      },
    },
  });

  upcomingReservations.forEach((reservation) => {
    const userId = reservation.userId;
    io.to(userId).emit('notification', {
      title: 'Upcoming Reservation',
      message: `Your reservation at ${reservation.location} is in 15 minutes.`,
    });
  });
});

module.exports = function (io) {
    io.on('connection', (socket) => {
    const userId = socket.handshake.query.userId; // Pass userId when connecting
    socket.join(userId);
  
    socket.on('disconnect', () => {
      socket.leave(userId);
    });
  });
}

  