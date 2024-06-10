""" This module contains the AccessRights model class. """
from dataclasses import dataclass
from peewee import CharField, IntegerField, Model

class AccessRights(Model):
    """
    Represents access rights in the system.

    Attributes:
    - access_right_id (int): The ID of the access right (mapped to 'pristupovaprava_id' column).
    - name (str): The name of the access right (mapped to 'nazev' column).
    """
    access_right_id = IntegerField(column_name='pristupovaprava_id', primary_key=True)
    name = CharField(column_name='nazev')

    @dataclass
    class Meta:
        """Metaclass for the AccessRights model."""
        table_name = 'pristupovaprava'
        database = None

    def __str__(self):
        """String representation of the AccessRights object."""
        return f"{self.name}"
