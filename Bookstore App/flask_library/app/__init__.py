from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
import uuid
from app.models import members
from functools import wraps
from datetime import datetime, timezone, timedelta
from app.extension import db

def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config.Config')

    db.init_app(app)

    from app.Route.BookRoute import books_bp
    from app.Route.AuthorRoute import authors_bp;
    from app.Route.MemberRoute import members_bp
    from app.Route.LendRoute import lendings_bp;
    from app.Route.principlesVersionsRoute import principles_bp;
    app.register_blueprint(books_bp)
    app.register_blueprint(authors_bp)
    app.register_blueprint(members_bp)
    app.register_blueprint(lendings_bp)
    app.register_blueprint(principles_bp)

    with app.app_context():
        db.create_all()  # create tables

    return app
