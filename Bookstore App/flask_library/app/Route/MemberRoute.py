from flask import Blueprint, jsonify, request
from app import db
from app.models import members

members_bp = Blueprint('members_bp', __name__, url_prefix='/api/members')

@members_bp.route("/", methods=["POST"])
def add_member():
    data = request.get_json(force=True)
    required = ["first_name", "last_name", "email"]
    missing = [k for k in required if not data.get(k)]
    if missing:
        return jsonify({"error": f"Missing fields: {', '.join(missing)}"}), 400

    member = members(
        first_name=data["first_name"].strip(),
        last_name=data["last_name"].strip(),
        email=data["email"].strip().lower(),
        phone=data.get("phone"),
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

# View all members
@members_bp.route("/", methods=["GET"])
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

# View member by id
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

