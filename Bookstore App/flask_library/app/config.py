import os

class Config:
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or 'postgresql://postgres:123@localhost/book'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = "1befa8d526f3b43cf2d9108fd385dccb23bce4039bbcb41c72e87d04976757866d91287193921d269d5da2898d0b07013164b128fa1c65979ad7b736eabba273"
        