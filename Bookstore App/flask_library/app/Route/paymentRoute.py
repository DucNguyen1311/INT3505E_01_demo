from flask import Flask, request, jsonify, Blueprint
from datetime import date
from app import db
from app.models import books, members, lendings
from app.auth import token_required

payment_v1 = Blueprint('payment_v1', __name__, url_prefix='/api/v1/payments');
payment_v2 = Blueprint('payment_v2', __name__, url_prefix='/api/v2/payments');

def mock_data_v1():
    return [
        {
            "id": "trans_v1_001",
            "user_id": "1",
            "amount": 200000,   
            "status": "SUCCESS",
            "created_at": "2023-01-10T08:30:00"
        },
        {
            "id": "trans_v1_002",
            "user_id": "2",
            "amount": 50000,
            "status": "FAILED",
            "created_at": "2023-01-12T09:15:00"
        }
    ];
def mock_data_v2():
    return [
        {
            "id": "trans_v2_101",
            "userId": "1",
            "amount": 10.5,
            "currency": "USD",
            "method": "paypal",
            "status": "SUCCESS",
            "timestamp": "2023-10-25T10:05:00"
        },
        {
            "id": "trans_v2_102",
            "userId": "2",
            "amount": 500,
            "currency": "EUR",
            "method": "credit_card",
            "status": "PENDING",
            "timestamp": "2023-11-01T14:20:00"
        }
    ];

@payment_v1.route("", methods=["GET"])
@token_required
def get_payments_v1():
    userID = request.args.get('userID', None)
    payments = mock_data_v1()
    deprecated_headers = {
        'Warning': '299 - "This API is deprecated. Please migrate to /api/v2/payments"'
    }
    if (userID):
        for (index, payment) in enumerate(payments):
            if payment["user_id"] == userID:
                return jsonify(payment), 200, deprecated_headers
        return jsonify({"error": "No payment found for the given userID"}), 404, deprecated_headers
    return jsonify(payments), 200, deprecated_headers
        

@payment_v2.route("", methods=["GET"])
@token_required
def get_payments_v2():
    payments = mock_data_v2()
    return jsonify(payments), 200