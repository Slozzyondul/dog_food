from flask import Flask, request, jsonify
from flask_cors import CORS
import requests
import base64
import datetime

app = Flask(__name__)
CORS(app)

# Replace with your actual credentials
CONSUMER_KEY = "LCwehFPUeTxTZiVrVYupilsP1Y1DmpAUk5GcJRgEWFWwNVfu"
CONSUMER_SECRET = "m9lHTIOJnYWwpD2k8efDe237TA44CATFmTGaM17pIyDmtZB6ACzYXX4daGEGpCTE"
PASS_KEY = "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919"
SHORTCODE = "174379"  # Your shortcode
CALLBACK_URL = "https://043d-154-123-39-112.ngrok-free.app"

# Get OAuth Token
def get_mpesa_token():
    url = "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
    credentials = f"{CONSUMER_KEY}:{CONSUMER_SECRET}"
    encoded_credentials = base64.b64encode(credentials.encode()).decode()

    headers = {
        "Authorization": f"Basic {encoded_credentials}",
    }

    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()  # Raise an exception for HTTP errors
        return response.json().get("access_token")
    except requests.exceptions.RequestException as e:
        print(f"Error generating token: {e}")
        return None

###logic to use payill/till number for paying
@app.route('/pay', methods=['POST'])
def lipa_na_mpesa():
    
    data = request.json
    phone_number = data.get("phone_number")  # Recipient's phone number
    amount = data.get("amount")

    token = get_mpesa_token()
    if not token:
        return jsonify({"error": "Failed to generate token"}), 500

    print(f"Generated Token: {token}")  # Log the token

    timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
    password = base64.b64encode(f"{SHORTCODE}{PASS_KEY}{timestamp}".encode()).decode()

    url = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
    }

    # Modify TransactionType and other details for sending money to a phone number
    payload = {
        "BusinessShortCode": SHORTCODE,  # Your shortcode
        "Password": password,
        "Timestamp": timestamp,
        "TransactionType": "CustomerBuyGoodsOnline",  # Correct transaction type
        "Amount": amount,
        "PartyA": phone_number,  # Phone number initiating the payment (sender)
        "PartyB": "254729684890",  
        "PhoneNumber": phone_number,  # The recipient's phone number
        "CallBackURL": CALLBACK_URL,
        "AccountReference": "Payment for Services",  # Customize as needed
        "TransactionDesc": f"Payment of KES {amount}",
    }

    try:
        response = requests.post(url, json=payload, headers=headers)
        response_data = response.json()

        print(f"STK Push Response: {response_data}")  # Log the STK push response

        if response.status_code == 200 and response_data.get("ResponseCode") == "0":
            return jsonify({"success": True, "message": "Payment initiated successfully"}), 200
        else:
            return jsonify({"error": response_data.get("errorMessage", "Payment failed")}), 500
    except requests.exceptions.RequestException as e:
        print(f"Error making STK push request: {e}")
        return jsonify({"error": "Failed to process payment"}), 500


####logic using B2C o direct phone number
# @app.route('/pay', methods=['POST'])
# def lipa_na_mpesa():
#     data = request.json
#     phone_number = data.get("phone_number")  # The sender's phone number
#     amount = data.get("amount")

#     token = get_mpesa_token()
#     if not token:
#         return jsonify({"error": "Failed to generate token"}), 500

#     print(f"Generated Token: {token}")  # Log the token

#     timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
#     password = base64.b64encode(f"{SHORTCODE}{PASS_KEY}{timestamp}".encode()).decode()

#     url = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"
#     headers = {
#         "Authorization": f"Bearer {token}",
#         "Content-Type": "application/json",
#     }

#     payload = {
#         "BusinessShortCode": SHORTCODE,  # Your M-Pesa PayBill or Till Number
#         "Password": password,
#         "Timestamp": timestamp,
#         "TransactionType": "CustomerPayBillOnline",  # For PayBill transactions
#         "Amount": amount,
#         "PartyA": phone_number,  # The sender's phone number (payer)
#         "PartyB": "254729684890",  # The recipient's fixed number
#         "PhoneNumber": phone_number,  # The sender's phone number (payer)
#         "CallBackURL": CALLBACK_URL,
#         "AccountReference": "Payment to Business",  # Change based on your business logic
#         "TransactionDesc": f"Payment of KES {amount} to 254729684890",
#     }

#     try:
#         response = requests.post(url, json=payload, headers=headers)
#         response_data = response.json()

#         print(f"STK Push Response: {response_data}")  # Log the response

#         if response.status_code == 200 and response_data.get("ResponseCode") == "0":
#             return jsonify({"success": True, "message": "Payment initiated successfully"}), 200
#         else:
#             return jsonify({"error": response_data.get("errorMessage", "Payment failed")}), 500
#     except requests.exceptions.RequestException as e:
#         print(f"Error making STK push request: {e}")
#         return jsonify({"error": "Failed to process payment"}), 500


@app.route('/mpesa_callback', methods=['POST'])
def mpesa_callback():
    """Handles STK push callback from Safaricom."""
    data = request.json  # Get the response data from Safaricom

    print(f"MPESA CALLBACK RECEIVED: {data}")  # Log the full response for debugging

    # Extract key details
    try:
        body = data.get("Body", {}).get("stkCallback", {})

        merchant_request_id = body.get("MerchantRequestID")
        checkout_request_id = body.get("CheckoutRequestID")
        result_code = body.get("ResultCode")
        result_desc = body.get("ResultDesc")

        # If payment was successful
        if result_code == 0:
            callback_metadata = body.get("CallbackMetadata", {}).get("Item", [])
            amount = next((item["Value"] for item in callback_metadata if item["Name"] == "Amount"), None)
            mpesa_receipt_number = next((item["Value"] for item in callback_metadata if item["Name"] == "MpesaReceiptNumber"), None)
            phone_number = next((item["Value"] for item in callback_metadata if item["Name"] == "PhoneNumber"), None)

            # Save payment details in your database
            # Example: Save to a database or perform further actions
            print(f"Payment Successful! Amount: {amount}, Receipt: {mpesa_receipt_number}, Phone: {phone_number}")

            return jsonify({"status": "success", "message": "Payment received"}), 200

        else:
            # Payment failed
            print(f"Payment Failed: {result_desc}")
            return jsonify({"status": "failed", "message": result_desc}), 400

    except Exception as e:
        print(f"Error processing callback: {e}")
        return jsonify({"status": "error", "message": "Failed to process callback"}), 500

if __name__ == '__main__':
    app.run(debug=True, port=5000)
