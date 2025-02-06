# from flask import Flask, request, jsonify
# from flask_cors import CORS
# import requests
# import base64
# import datetime

# app = Flask(__name__)
# CORS(app)

# # Replace with your actual credentials
# CONSUMER_KEY = "LCwehFPUeTxTZiVrVYupilsP1Y1DmpAUk5GcJRgEWFWwNVfu"
# CONSUMER_SECRET = "m9lHTIOJnYWwpD2k8efDe237TA44CATFmTGaM17pIyDmtZB6ACzYXX4daGEGpCTE"
# PASS_KEY = "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919"
# SHORTCODE = "174379"
# CALLBACK_URL = "https://your-callback-url.com"

# # Get OAuth Token
# def get_mpesa_token():
#     url = "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
#     credentials = f"{CONSUMER_KEY}:{CONSUMER_SECRET}"
#     encoded_credentials = base64.b64encode(credentials.encode()).decode()

#     headers = {
#         "Authorization": f"Basic {encoded_credentials}",
#     }

#     try:
#         response = requests.get(url, headers=headers)
#         response.raise_for_status()  # Raise an exception for HTTP errors
#         return response.json().get("access_token")
#     except requests.exceptions.RequestException as e:
#         print(f"Error generating token: {e}")
#         return None

# @app.route('/pay', methods=['POST'])
# def lipa_na_mpesa():
#     data = request.json
#     phone_number = data.get("phone_number")
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
#         "BusinessShortCode": SHORTCODE,
#         "Password": password,
#         "Timestamp": timestamp,
#         "TransactionType": "CustomerPayBillOnline",
#         "Amount": amount,
#         "PartyA": phone_number,
#         "PartyB": SHORTCODE,
#         "PhoneNumber": phone_number,
#         "CallBackURL": CALLBACK_URL,
#         "AccountReference": "Dog Food Order",
#         "TransactionDesc": f"Payment of KES {amount}",
#     }

#     try:
#         response = requests.post(url, json=payload, headers=headers)
#         response_data = response.json()

#         print(f"STK Push Response: {response_data}")  # Log the STK push response

#         if response.status_code == 200 and response_data.get("ResponseCode") == "0":
#             return jsonify({"success": True, "message": "Payment initiated successfully"}), 200
#         else:
#             return jsonify({"error": response_data.get("errorMessage", "Payment failed")}), 500
#     except requests.exceptions.RequestException as e:
#         print(f"Error making STK push request: {e}")
#         return jsonify({"error": "Failed to process payment"}), 500

# if __name__ == '__main__':
#     app.run(debug=True, port=5000)

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
CALLBACK_URL = "https://your-callback-url.com"

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
        "PartyB": SHORTCODE,  # Your shortcode as PartyB
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

if __name__ == '__main__':
    app.run(debug=True, port=5000)
