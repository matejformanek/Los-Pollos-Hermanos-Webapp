""" This module contains the Cooking model class. """
from dataclasses import dataclass
from peewee import DateField, IntegerField, Model


class Cooking(Model):
    """
    Represents cooking information in the system.

    Attributes:
    - cooking_id (int): The ID of the cooking record (mapped to 'vareni_id' column).
    - date (str): The date of cooking (mapped to 'datum' column).
    """
    cooking_id = IntegerField(column_name='vareni_id', primary_key=True)
    date = DateField(column_name='datum')

    @dataclass
    class Meta:
        """Metaclass for the Cooking model."""
        table_name = 'vareni'
        database = None

    def __str__(self):
        """String representation of the Cooking object."""
        return f"Cooking ID: {self.cooking_id}, Date: {self.date}"
