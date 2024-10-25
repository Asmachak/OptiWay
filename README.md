<h1>Event Synchronization & Parking Management App</h1>
    <p>
        This mobile application, developed as part of my end-of-study internship at <strong>VIVIA Clinical Solutions</strong>, 
        provides seamless solutions for <strong>parking reservations</strong> and <strong>event synchronization</strong>. 
        Built using <strong>Flutter</strong> and <strong>Node.js</strong> with a <strong>PgSQL</strong> database, 
        the app is designed for scalability, responsiveness, and a clean, modular architecture.
    </p>
    <h2>Features</h2>
    <ul>
        <li><strong>Security and Authentication</strong>: <br> <strong> * Secure Authentication</strong>: Implements robust, secure authentication using industry-standard encryption and token-based sessions.<br><strong>* Email Verification with OTP </strong> Verifies user email addresses using an OTP (One-Time Password) sent via email, enhancing user account security and ensuring verified access. </li>
        <li><strong>Real-Time Event Synchronization and notifications </strong>: Using <code>Socket.io </code> for dynamic updates, ensuring users receive live event changes and discounts. Also a user receive notifications for his reservations state and always a reminder before 15min the reservation expires.</li>
        <li><strong>Parking Reservation Management</strong>: Provides users with an easy-to-use interface for booking and managing parking slots.</li>
        <li><strong>Event Reservation Management</strong>: Provides users with an easy-to-use interface for booking and managing events related to parkings.</li>
        <li><strong>Data Aggregation through Web Scraping for Cinema Events</strong>: Web scraping gathers up-to-date event details from cinema websites, enabling real-time synchronization of movie showtimes, titles, and locations. This ensures users always see the latest events available in nearby cinema venues, enhancing their experience with fresh, relevant information.</li>
        <li><strong>Secure Payment Integration with Stripe</strong>: Supports secure, streamlined payments through Stripe, enabling users to complete parking reservations or event-related transactions directly within the app.</li>
        <li><strong>Clean Architecture</strong>: Ensures code modularity and maintainability, allowing for efficient scaling and future development.</li>
    </ul>
    <h2>User Roles</h2>
     <ul>
        <li><strong>Administrator</strong>: Manages users, oversees event and parking listings, and moderates content. Has access to an analytics dashboard for app performance insights. The administrator can definitively delete a user or an organizer from the app, and get blacklisted because of multitudes of complaints and reports.</li>
        <li><strong>Client</strong>: Users who reserve parking slots or attend events. They have access to booking history, payment processing, and real-time event and reservation notifications.</li>
        <li><strong>Organizer</strong>: Manages event listings and can update event details in real-time. Organizers can also use analytics to monitor event engagement.</li>
    </ul>
    <p>The app provides tailored experiences for three user types:</p>
    <h2>Tech Stack</h2>
    <ul>
        <li><strong>Frontend</strong>: Flutter</li>
        <li><strong>Backend</strong>: Node.js, Socket.io</li>
        <li><strong>Database</strong>: PostgreSQL (PgSQL)</li>
        <li><strong>Architecture</strong>: MVC, Clean Architecture principles</li>
        <li><strong>Tools</strong>: Git/GitHub for version control</li>
    </ul>
