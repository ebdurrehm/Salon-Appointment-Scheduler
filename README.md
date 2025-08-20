# 🏪 Salon Appointment System

A command-line salon booking application built with Bash and PostgreSQL for managing customer appointments and services.

## 📋 Features

- **Interactive Menu System**: User-friendly command-line interface for service selection
- **Customer Management**: Automatic customer registration and lookup by phone number
- **Service Booking**: Complete appointment scheduling with time management
- **Database Integration**: PostgreSQL backend for reliable data storage
- **Input Validation**: Robust error handling and service validation

## 🛠️ Technologies Used

- **Bash**: Shell scripting for application logic
- **PostgreSQL**: Database management system
- **psql**: Command-line interface for database operations

## 🚀 Getting Started

### Prerequisites

- PostgreSQL installed and running
- Database named `salon` with appropriate tables:
  - `services` (service_id, name)
  - `customers` (customer_id, name, phone)
  - `appointments` (appointment_id, customer_id, service_id, time)

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd salon-appointment-system
   ```

2. Make the script executable:
   ```bash
   chmod +x salon.sh
   ```

3. Run the application:
   ```bash
   ./salon.sh
   ```

## 📖 Usage

1. **Select a Service**: Choose from available salon services
2. **Provide Phone Number**: Enter your contact information
3. **Register (if new)**: First-time customers will be prompted for their name
4. **Schedule Appointment**: Select your preferred appointment time
5. **Confirmation**: Receive booking confirmation with details

## 🎯 Example Workflow

```
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?

1) cut
2) color
3) perm

> 1

What's your phone number?
> 555-1234

I don't have a record for that phone number, what's your name?
> John Doe

What time would you like your cut, John Doe?
> 10:30

I have put you down for a cut at 10:30, John Doe.
```

## 🗃️ Database Schema

The application expects these PostgreSQL tables:

```sql
-- Services table
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Customers table  
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

-- Appointments table
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    service_id INT REFERENCES services(service_id),
    time VARCHAR(10) NOT NULL
);
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

Created as part of the FreeCodeCamp Relational Database certification project.

---

⭐ **Star this repository if you found it helpful!**
