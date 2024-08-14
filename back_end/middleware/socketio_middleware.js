const socketIo = require('socket.io');

function initializeSocket(server) {
    const io = socketIo(server);

    // Socket.io middleware to authenticate users and store the socket ID
    io.use((socket, next) => {
        const userId = socket.handshake.auth.userId;
        if (!userId) {
            return next(new Error('Invalid user ID'));
        }
        socket.userId = userId; // Attach the userId to the socket
        next();
    });

    io.on('connection', (socket) => {
        console.log(`User connected: ${socket.userId}`);

        // Optional: Send a welcome message or current notifications to the user
        socket.emit('welcome', 'Welcome to the notification service!');

        socket.on('disconnect', () => {
            console.log(`User disconnected: ${socket.userId}`);
        });
    });

    return io;
}

module.exports = { initializeSocket };
