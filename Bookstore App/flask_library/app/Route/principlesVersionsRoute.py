from flask import Blueprint, jsonify, request, make_response
from app import db
from app.models import members

principles_bp = Blueprint('principles_bp', __name__, url_prefix='/principle')

books = [{"id": 1, "title": "REST Basics"}]
TOKEN = "abc123"

#Version 1, principle Client-Server, tách biệt phía client và server. Client gửi GET / Book, server trả về danh sách JSON
@principles_bp.route('/p1/books', methods=['GET'])
def get_booksv1():
    return jsonify(books)

#Version 2, principle Stateless, server không nhớ trạng thái người dùng, trong server cần AUTH, mọi request đều gửi token thời gian thực
@principles_bp.route('/p2/books', methods=['GET'])
def get_booksv2():
    auth = request.headers.get("Authorization")
    if auth != f"Bearer {TOKEN}":
        return jsonify({"error": "Unauthorized"}), 401
    return jsonify(books)

#Version 3, principle Cacheable. Response có thể được cache để giảm tải server, Response nên có header cache-control.

@principles_bp.route('/p3/books', methods=['GET'])
def get_booksv3():
    auth = request.headers.get("Authorization")
    if auth != f"Bearer {TOKEN}":
        return jsonify({"error": "Unauthorized"}), 401
    
    resp = make_response(jsonify(books))
    resp.headers["Cache-Control"] = "max-age=60"
    return resp

#Version 4, principle Uniform Interface, Giao tiếp phải tuân theo quy chuẩn thống nhất.

@principles_bp.route('/p4/books', methods=['GET'])
def get_booksv4():
    auth = request.headers.get("Authorization")
    if auth != f"Bearer {TOKEN}":
        return jsonify({"error": "Unauthorized"}), 401
    
    resp = make_response(jsonify(books), 200)
    resp.headers["Cache-Control"] = "max-age=60"
    return resp

@principles_bp.route('p4/books/<int:book_id>', methods=['GET'])
def get_bookv4(book_id):
    auth = request.headers.get("Authorization")
    if auth != f"Bearer {TOKEN}":
        return jsonify({"error": "Unauthorized"}), 401
    
    for b in books:
        if b["id"] == book_id:
            resp = make_response(jsonify(books), 200)
            resp.headers["Cache-Control"] = "max-age=60"
            return resp
    return jsonify({"error": "Not found"}), 404

@principles_bp.route('p4/books', methods=['POST'])
def create_bookv4():
    auth = request.headers.get("Authorization")
    if auth != f"Bearer {TOKEN}":
        return jsonify({"error": "Unauthorized"}), 401
    data = request.json
    books.append({"id": len(books)+1, "title": data["title"]})
    return jsonify(books[-1]), 201
