""" This module contains the Cook model class. """
from dataclasses import dataclass
from peewee import IntegerField
from src.dl.entity.user import User

class Cook(User):
    """
    Represents a cook in the system.

    Attributes:
    - cook_id (int): The ID of the cook (mapped to 'kuchar_id' column).
    - years_experience (int): The cook's years of experience (mapped to 'roky_praxe' column).
    """
    cook_id = IntegerField(column_name='kuchar_id', primary_key=True)
    years_experience = IntegerField(column_name='roky_praxe')

    @dataclass
    class Meta:
        """Metaclass for the Cook model."""
        table_name = 'kuchar'
        database = None

    def __str__(self):
        """String representation of the Cook object."""
        return f"{self.name} {self.surname} ({self.years_experience} years)"
