from flask import Flask, request, jsonify, Blueprint
from datetime import date
from app import db
from app.models import books, members, lendings

lendings_bp = Blueprint('lends_bp', __name__, url_prefix='/api/lendings')

@lendings_bp.route("/", methods=["POST"])
def create_lending():
    data = request.get_json(force=True) or {}
    required = ["book_id", "member_id", "due_date"]
    missing = [k for k in required if not data.get(k)]
    if missing:
        return jsonify({"error": f"Missing fields: {', '.join(missing)}"}), 400

    try:
        due = date.fromisoformat(data["due_date"])
    except ValueError:
        return jsonify({"error": "due_date must be ISO format YYYY-MM-DD"}), 400

    # Ensure book and member exist
    book = books.query.get(data["book_id"])
    if not book:
        return jsonify({"error": "Book not found"}), 404
    member = members.query.get(data["member_id"])
    if not member:
        return jsonify({"error": "Member not found"}), 404

    # Check if book is currently lent out (no return_date)
    active = lendings.query.filter_by(book_id=book.book_id, return_date=None).first()
    if active:
        return jsonify({"error": "Book is already lent out"}), 409

    lending = lendings(
        book_id=book.book_id,
        member_id=member.member_id,
        due_date=due
    )
    db.session.add(lending)
    db.session.commit()

    return jsonify({
        "lending_id": lending.lending_id,
        "book_id": lending.book_id,
        "member_id": lending.member_id,
        "lend_date": lending.lend_date.isoformat(),
        "due_date": lending.due_date.isoformat(),
        "return_date": lending.return_date
    }), 201
