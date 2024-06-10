""" This module contains the Address model class. """
from dataclasses import dataclass
from peewee import CharField, IntegerField, Model

class Address(Model):
    """
    Represents an address in the system.

    Attributes:
    - address_id (int): The ID of the address (mapped to 'adresa_id' column).
    - importer_id (int): The ID of the importer (mapped to 'dodavatel_id' column).
    - location_id (int): The ID of the location (mapped to 'lokalita_id' column).
    - state (str): The state of the address (mapped to 'stat' column).
    - city (str): The city of the address (mapped to 'mesto' column).
    - postal_code (str): The postal code of the address (mapped to 'psc' column).
    - street (str): The street of the address (mapped to 'ulice' column).
    """
    address_id = IntegerField(column_name='adresa_id', primary_key=True)
    importer_id = IntegerField(column_name='dodavatel_id')
    location_id = IntegerField(column_name='lokalita_id')
    state = CharField(column_name='stat')
    city = CharField(column_name='mesto')
    postal_code = CharField(column_name='psc')
    street = CharField(column_name='ulice')

    @dataclass
    class Meta:
        """Metaclass for the Address model."""
        table_name = 'adresa'
        database = None

    def __str__(self):
        """String representation of the Address object."""
        return f"{self.street}, {self.city}, {self.postal_code}"
