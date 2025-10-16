from app.extension import db
from datetime import date
from sqlalchemy.orm import relationship

class authors(db.Model):
    author_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    author_name = db.Column(db.String(255), nullable=False)
    author_nationality = db.Column(db.String(100))
    author_dob = db.Column(db.Date)
    books = relationship("books", back_populates="author", cascade="all, delete-orphan", lazy="selectin")


class members(db.Model):
    member_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(100), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(255), unique=True, nullable=False)
    phone = db.Column(db.String(20))
    membership_start = db.Column(db.Date, default=date.today, nullable=False)
    password = db.Column(db.String(100))

class books(db.Model):
    book_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    author_id = db.Column(db.String(255),db.ForeignKey("authors.author_id"), nullable=False)
    published_year = db.Column(db.Integer)
    author = relationship("authors", back_populates="books")

class lendings(db.Model):
    lending_id = db.Column(db.Integer, primary_key=True)
    book_id = db.Column(db.Integer, db.ForeignKey('books.book_id'), nullable=False)
    member_id = db.Column(db.Integer, db.ForeignKey('members.member_id'), nullable=False)
    lend_date = db.Column(db.Date, default=date.today, nullable=False)
    due_date = db.Column(db.Date, nullable=False)
    return_date = db.Column(db.Date)

class category(db.Model):
    __tablename__ = 'categories'
    category_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)

class bookCategory(db.Model):
    __tablename__ = 'book_categories'
    book_id = db.Column(db.Integer, db.ForeignKey('books.book_id'), primary_key=True, nullable=False)
    category_id = db.Column(db.Integer, db.ForeignKey('categories.category_id'), primary_key=True, nullable=False)

def serialize_book(b: books):
    return {
        "book_id": b.book_id,
        "title": b.title,
        "author_id": b.author_id,
        "published_year": b.published_year,
    }