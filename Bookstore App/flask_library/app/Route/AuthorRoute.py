from flask import Blueprint, jsonify, request
from app import db
from app.models import authors, serialize_book
from datetime import date

authors_bp = Blueprint('authors_bp', __name__, url_prefix='/api/authors')

@authors_bp.get("/<int:author_id>/books")
def list_author_books(author_id: int):
    author = authors.query.get(author_id)
    if author is None:
        abort(404, description="Author not found")
    return jsonify([serialize_book(b) for b in author.books])

@authors_bp.route('', methods=['POST'])
def add_author():
    data = request.get_json()
    required_fields = ['author_name']
    for field in required_fields:
        if field not in data:
            return jsonify({'error': f'Missing field: {field}'}), 400

    new_author = authors(
        author_name=data['author_name'],
        author_nationality=data.get('author_nationality'),
        author_dob=data.get('author_dob') 
    )
    db.session.add(new_author)
    db.session.commit()
    return jsonify({'message': 'Author added', 'author_id': new_author.author_id}), 201

@authors_bp.route('', methods=['GET'])
def show_all_authors():
    author_list = authors.query.all()
    result = []
    for a in author_list:
        result.append({
            'author_id': a.author_id,
            'author_name': a.author_name,
            'author_nationality': a.author_nationality,
            'author_dob': str(a.author_dob) if a.author_dob else None
        })
    return jsonify(result), 200

@authors_bp.route('/<int:author_id>', methods=['GET'])
def get_author_by_id(author_id):
    author = authors.query.get(author_id)
    if not author:
        return jsonify({'error': 'Author not found'}), 404
    result = {
        'author_id': author.author_id,
        'author_name': author.author_name,
        'author_nationality': author.author_nationality,
        'author_dob': str(author.author_dob) if author.author_dob else None
    }
    return jsonify(result), 200

@authors_bp.route('/bulk', methods=['POST'])
def add_authors_bulk():
    payload = request.get_json(force=True)
    if not isinstance(payload, list):
        return jsonify({'error': 'Body must be a JSON array of author objects'}), 400

    required = ['author_name']
    new_rows = []
    errors = []

    for idx, item in enumerate(payload):
        if not isinstance(item, dict):
            errors.append({'index': idx, 'error': 'Item must be an object'})
            continue

        missing = [k for k in required if k not in item]
        if missing:
            errors.append({'index': idx, 'error': f"Missing fields: {', '.join(missing)}"})
            continue

        # Optional date validation if provided (YYYY-MM-DD)
        dob = item.get('author_dob')
        if dob:
            try:
                date.fromisoformat(dob)
            except ValueError:
                errors.append({'index': idx, 'error': 'author_dob must be ISO format YYYY-MM-DD'})
                continue

        new_rows.append(authors(
            author_name=item['author_name'],
            author_nationality=item.get('author_nationality'),
            author_dob=dob
        ))

    if errors:
        return jsonify({'error': 'Validation failed', 'details': errors}), 400

    try:
        db.session.add_all(new_rows)
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'error': 'Integrity error during bulk insert'}), 409

    return jsonify({
        'message': 'Authors added',
        'created': [{'author_id': row.author_id, 'author_name': row.author_name} for row in new_rows]
    }), 201