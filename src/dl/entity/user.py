""" This module contains the User model class. """
from dataclasses import dataclass
from peewee import CharField, DateField, IntegerField, Model


class User(Model):
    """
    Represents a user in the system.

    Attributes:
    - user_id (int): The ID of the user (mapped to 'zamestnanec_id' column).
    - address (int): The ID of the address (mapped to 'adresa_id' column).
    - email (str): The email of the user (mapped to 'mail' column).
    - password (str): The password of the user (mapped to 'heslo' column).
    - date_of_birth (str): The date of birth of the user (mapped to 'datum_narozeni' column).
    - name (str): The name of the user (mapped to 'jmeno' column).
    - surname (str): The surname of the user (mapped to 'prijmeni' column).
    """
    user_id = IntegerField(column_name='zamestnanec_id', primary_key=True)
    address = IntegerField(column_name='adresa_id')
    email = CharField(column_name='mail')
    password = CharField(column_name='heslo')
    date_of_birth = DateField(column_name='datum_narozeni')
    name = CharField(column_name='jmeno')
    surname = CharField(column_name='prijmeni')

    @dataclass
    class Meta:
        """Metaclass for the User model."""
        table_name = 'zamestnanec'

    def __str__(self):
        """String representation of the User object."""
        return f"{self.name} {self.surname}"
