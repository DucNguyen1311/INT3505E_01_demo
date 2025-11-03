# auth.py
from functools import wraps
from flask import request, jsonify, current_app
import jwt     
from app.models import members
import logging

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None 

        # 1. Try to get token from 'Authorization: Bearer <token>' header
        if 'Authorization' in request.headers:
            auth_header = request.headers['Authorization']
            try:
                token = auth_header.split(" ")[1]
            except IndexError:
                return jsonify({'message': 'Bearer token is malformed!'}), 401
        
        # 2. If no header, fallback to checking for the cookie
        if not token:
            token = request.cookies.get('jwt_token')

        # 3. If still no token, it's missing
        if not token:
            return jsonify({'message': 'Token is missing!'}), 401

        # 4. Decode the token and find the user
        try:
            # This is the part that decodes
            data = jwt.decode(token, current_app.config['SECRET_KEY'], algorithms=["HS256"])
            
            # This is the database query
            current_user = members.query.filter_by(member_id=data['public_id']).first()

        # --- THIS IS THE FIX ---
        # Catch specific errors so you know what's wrong
        except jwt.ExpiredSignatureError:
            return jsonify({'message': 'Token has expired!'}), 401
        except jwt.InvalidTokenError:
            return jsonify({'message': 'Token signature is invalid!'}), 401
        except Exception as e:
            # Catch any other database or logic errors
            logging.error(f"Token processing error: {str(e)}")
            return jsonify({'message': 'Token processing error!'}), 401

        # 5. Check if user was actually found
        if not current_user:
            return jsonify({'message': 'User associated with token not found!'}), 401

        # All checks passed, pass the user object to the route
        return f(current_user, *args, **kwargs)

    return decorated

def role_required(role):
    def wrapper(fn):
        @wraps(fn)
        def decorator (current_user, *args, **kwargs):
            if current_user.member_type == role:
                return fn(current_user, *args, **kwargs)  # User has the role, continue
            else:
                return jsonify(msg=f"'{role}' access required!"), 403 # 403 Forbidden

        return decorator
    return wrapper