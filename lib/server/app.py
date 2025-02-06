from flask import Flask, request, jsonify
from flask_cors import CORS
import requests
import base64
import datetime

app = Flask(__name__)
CORS(app)  

# Replace with your actual credentials
CONSUMER_KEY = "AcHZUG5W4IcLmtLHZ2w94biCZUGDftmVGM864x44Apw8oN8e"
CONSUMER_SECRET = "mdXkQpGf1LXm8HOCBb5HhZyhdCYDFDQZ9yJ1QFRoA9CqyfyPfLeZprKAsAwi7hQK"
PASS_KEY = "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919"
SHORTCODE = "174379"
CALLBACK_URL = "https://your-callback-url.com"

RECIPIENT_PHONE_NUMBER = "254729684890"  

# Get OAuth Token
def get_mpesa_token():
    url = "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
    credentials = f"{CONSUMER_KEY}:{CONSUMER_SECRET}"
    encoded_credentials = base64.b64encode(credentials.encode()).decode()

    headers = {
        "Authorization": f"Basic {encoded_credentials}",
    }
    print("Fetching token from URL:", url)  


    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.json().get("access_token")
    else:
        return None

@app.route('/pay', methods=['POST'])
def lipa_na_mpesa():
    data = request.json
    phone_number = data.get("phone_number")
    amount = data.get("amount")

    token = get_mpesa_token()
    if not token:
        return jsonify({"error": "Failed to generate token"}), 500

    timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
    password = base64.b64encode(f"{SHORTCODE}{PASS_KEY}{timestamp}".encode()).decode()

    url = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
    }

    payload = {
        "BusinessShortCode": SHORTCODE,
        "Password": password,
        "Timestamp": timestamp,
        "TransactionType": "CustomerPayBillOnline",
        "Amount": amount,
        "PartyA": phone_number,
        "PartyB": RECIPIENT_PHONE_NUMBER,
        "PhoneNumber": phone_number,
        "CallBackURL": CALLBACK_URL,
        "AccountReference": "Dog Food Order",
        "TransactionDesc": f"Payment of KES {amount} to 254729684890",
    }

    response = requests.post(url, json=payload, headers=headers)

    return response.json(), response.status_code

if __name__ == '__main__':
    app.run(debug=True, port=5000)
