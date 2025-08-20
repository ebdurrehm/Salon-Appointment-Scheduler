#!/bin/bash

# Database connection
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

# Main menu function
MAIN_MENU() {
    # Display error message if provided
    if [[ $1 ]]; then
        echo -e "\n$1\n"
    fi
    
    # Welcome message
    echo "~~~~~ MY SALON ~~~~~"
    echo -e "\nWelcome to My Salon, how can I help you?\n"
    
    # Get and display services
    SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
    
    if [[ -z $SERVICES ]]; then
        echo "No services available."
        return
    fi
    
    echo "$SERVICES" | while IFS='|' read SERVICE_ID SERVICE_NAME; do
        echo "$SERVICE_ID) $SERVICE_NAME"
    done
    
    # Get user selection
    read SERVICE_ID_SELECTED
    
    # Validate service selection
    VALID_SERVICE=$($PSQL "SELECT service_id FROM services WHERE service_id='$SERVICE_ID_SELECTED'")
    
    if [[ -z $VALID_SERVICE ]]; then
        MAIN_MENU "I could not find that service. What would you like today?"
    else
        TAKE_SERVICE "$SERVICE_ID_SELECTED"
    fi
}

# Service booking function
TAKE_SERVICE() {
    SERVICE_ID=$1
    
    # Get service name
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID'")
    
    # Get customer phone
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    
    # Check if customer exists
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    
    # If new customer, get name and insert
    if [[ -z $CUSTOMER_NAME ]]; then
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        
        INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi
    
    # Get customer ID
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    
    # Get appointment time
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME
    
    # Insert appointment
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID', '$SERVICE_TIME')")
    
    # Confirm appointment
    if [[ $INSERT_APPOINTMENT == "INSERT 0 1" ]]; then
        echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    else
        echo -e "\nSorry, there was an error booking your appointment."
    fi
}

# Start the program
MAIN_MENU