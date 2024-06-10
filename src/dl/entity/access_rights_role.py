""" This module contains the AccessRightsRole model class. """
from dataclasses import dataclass
from peewee import IntegerField, Model

class AccessRightsRole(Model):
    """
    Represents access rights with roles in the system.

    Attributes:
    - access_right_id (int): The ID of the access right (mapped to 'pristupovaprava_id' column).
    - role_id (int): The ID of the role (mapped to 'role_id' column).
    """
    access_right_id = IntegerField(column_name='pristupovaprava_id', primary_key=True)
    role_id = IntegerField(column_name='role_id')

    @dataclass
    class Meta:
        """Metaclass for the AccessRightsRole model."""
        table_name = 'role_pristupovaprava'
        database = None

    def __str__(self):
        """String representation of the AccessRights object."""
        return f"{self.access_right_id} {self.role_id}"
