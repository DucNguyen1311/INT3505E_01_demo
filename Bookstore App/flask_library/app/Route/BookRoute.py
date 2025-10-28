from flask import Blueprint, jsonify, request
from app import db
from app.models import books
from sqlalchemy.exc import IntegrityError
from app.auth import token_required

books_bp = Blueprint('books_bp', __name__, url_prefix='/api/v1/books')
books_bp2 = Blueprint('books_bp2', __name__, url_prefix='/api/v2/books')

@token_required
@books_bp.route('', methods=['GET'])
def get_books():
    title_query = request.args.get('title', None)
    page = request.args.get('page', default=1, type=int)
    limit = request.args.get('limit', default=10, type=int)
    bookQuery = books.query
    if title_query:
        bookQuery = bookQuery.filter(books.title.ilike(f"%{title_query}%"))
    pagination = bookQuery.paginate(page=page, per_page=limit, error_out=False)
    result = pagination.items
    return jsonify([{
        'book_id': b.book_id,
        'title': b.title,
        'author_id': b.author_id,
        'published_year': b.published_year
    } for b in result])

@token_required
@books_bp.route('', methods=['POST'])
def add_book():
    data = request.get_json()
    required_fields = ['title', 'author_id']
    for field in required_fields:
        if field not in data:
            return jsonify({'error': f'Missing field: {field}'}), 400

    new_book = books(
        title=data['title'],
        author_id=data['author_id'],
        published_year=data.get('published_year')
    )

    db.session.add(new_book)
    db.session.commit()

    return jsonify({'message': 'Book added successfully!', 'book_id': new_book.book_id}), 201

@token_required
@books_bp.route('/bulk', methods=['POST'])
def add_books():
    data = request.get_json()
    if not isinstance(data, list):
        return jsonify({'error'}), 400
    
    required = ['title', 'author_id']
    new_rows = []
    errors = []
    for idx, item in enumerate(data):
        if not isinstance(item, dict):
            errors.append({'index': idx, 'error': 'Item must be an object'})
            continue
        missing = [k for k in required if k not in item]
        if missing:
            errors.append({'index': idx, 'error': f"Missing fields: {', '.join(missing)}"})
            continue
        new_rows.append(books(
            title=item['title'],
            author_id=int(item['author_id']),
            published_year=int(item.get('published_year'))
        ))

    if errors:
        return jsonify({'error': 'Validation failed', 'details': errors}), 400
    
    try:
        db.session.bulk_save_objects(new_rows)
        db.session.commit()
    except IntegrityError:
        db.session.rollback()
        return jsonify({'error'})
    
    return jsonify({
        'message': 'Books added successfully!',
        'created': [{'book_id': row.book_id, 'title': row.title} for row in new_rows]
    }), 201

