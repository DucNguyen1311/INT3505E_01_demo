from datetime import datetime, timedelta, timezone
from flask import Blueprint, jsonify, request, current_app, make_response
from app import db
from app.models import members
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
from app.auth import token_required

members_bp = Blueprint('members_bp', __name__, url_prefix='/api/members')

@members_bp.route("", methods=["POST"])
def add_member():
    data = request.get_json(force=True)
    required = ["first_name", "last_name", "email", "password"]
    missing = [k for k in required if not data.get(k)]
    if missing:
        return jsonify({"error": f"Missing fields: {', '.join(missing)}"}), 400

    existingMember = members.query.filter_by(email=data.get("email")).first()
    if existingMember:
        return jsonify({'message': 'User already exists. Please login.'}), 400
    hashed_password = generate_password_hash(data.get("password"))


    member = members(
        first_name=data["first_name"].strip(),
        last_name=data["last_name"].strip(),
        email=data["email"].strip().lower(),
        phone=data.get("phone"),
        password = hashed_password,
        membership_start=data.get("membership_start")  # ISO date "YYYY-MM-DD" optional
    )
    try:
        db.session.add(member)
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({"error": "Email already exists"}), 409

    return jsonify({
        "member_id": member.member_id,
        "first_name": member.first_name,
        "last_name": member.last_name,
        "email": member.email,
        "phone": member.phone,
        "membership_start": member.membership_start.isoformat()
    }), 201

@token_required
@members_bp.route("", methods=["GET"])
def get_members():
    members = members.query.order_by(members.member_id.asc()).all()
    return jsonify([
        {
            "member_id": m.member_id,
            "first_name": m.first_name,
            "last_name": m.last_name,
            "email": m.email,
            "phone": m.phone,
            "membership_start": m.membership_start.isoformat()
        } for m in members
    ]), 200

@token_required
@members_bp.route("/<int:member_id>", methods=["GET"])
def get_member(member_id):
    m = members.query.get(member_id)
    if not m:
        return jsonify({"error": "Member not found"}), 404
    return jsonify({
        "member_id": m.member_id,
        "first_name": m.first_name,
        "last_name": m.last_name,
        "email": m.email,
        "phone": m.phone,
        "membership_start": m.membership_start.isoformat()
    }), 200


@members_bp.route("/authentication", methods=["POST"])
def login():
    data = request.get_json(silent=True) or {}
    email = data.get("email")
    password = data.get("password")
    if not email or not password:
        return jsonify({"message": "Email và password là bắt buộc"}), 400

    user = members.query.filter_by(email=email).first()
    if not user or not check_password_hash(user.password, password):
        return jsonify({"message": "Invalid email or password"}), 401
    exp = datetime.now(timezone.utc) + timedelta(hours=1)
    token = jwt.encode({"public_id": user.member_id, "exp": exp}, current_app.config["SECRET_KEY"], algorithm="HS256")

    body = {"token": token, "token_type": "Bearer", "expires_in": 3600}
    resp = make_response(jsonify(body), 200)
    resp.headers["Cache-Control"] = "no-store"
    resp.headers["Pragma"] = "no-cache"
    return resp
