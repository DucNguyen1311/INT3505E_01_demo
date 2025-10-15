from flask import Flask
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config.Config')

    db.init_app(app)

    from app.Route.BookRoute import books_bp
    from app.Route.AuthorRoute import authors_bp;
    from app.Route.MemberRoute import members_bp
    from app.Route.LendRoute import lendings_bp;
    app.register_blueprint(books_bp)
    app.register_blueprint(authors_bp)
    app.register_blueprint(members_bp)
    app.register_blueprint(lendings_bp)

    with app.app_context():
        db.create_all()  # create tables

    return app
