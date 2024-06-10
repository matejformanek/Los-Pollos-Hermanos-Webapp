""" This module contains the Branch model class. """
from dataclasses import dataclass
from peewee import CharField, IntegerField, Model

class Branch(Model):
    """
    Represents a branch in the system.

    Attributes:
    - name (str): The branch's name (mapped to 'nazev' column).
    - branch_id (int): The ID of the branch (mapped to 'pobocka_id' column).
    """
    name = CharField(column_name='nazev')
    id = IntegerField(column_name='pobocka_id', primary_key=True)

    @dataclass
    class Meta:
        """Metaclass for the Branch model."""
        table_name = 'pobocka'
        database = None

    def __str__(self):
        """String representation of the Branch object."""
        return f"{self.name}"
