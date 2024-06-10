""" This module manages the connection to the PostgreSQL database. """
import os
import re
from peewee import PostgresqlDatabase, Model


class DatabaseManager:
    """ Manages the connection to the PostgreSQL database."""
    _instance = None

    def __new__(cls, *args, **kwargs):
        """
        Singleton pattern.
        """
        if not cls._instance:
            cls._instance = super().__new__(cls)
            cls._instance.db = None
        return cls._instance

    def __init__(self):
        """
        Connects to the PostgreSQL database using the environment variable DB_CONNECTION_STRING.
        """
        # Parse DB_CONNECTION_STRING from the environment
        db_connection_string = os.getenv('DB_CONNECTION_STRING')
        strings = db_connection_string.split()
        db_name = re.findall(r"'([^']*)'", strings[0])[0]
        db_user = re.findall(r"'([^']*)'", strings[1])[0]
        db_password = re.findall(r"'([^']*)'", strings[2])[0]
        db_host = re.findall(r"'([^']*)'", strings[3])[0]
        # Initialize the PostgreSQL database
        self.db = PostgresqlDatabase(
            db_name, user=db_user, password=db_password, host=db_host)
        # Initialize the database connection
        self.db.connect(True)

    def bind(self):
        """ Binds all models to the database."""
        for model in Model.__subclasses__():
            model.bind(self.db)
