""" This module contains the Role model class."""
from dataclasses import dataclass
from peewee import CharField, DateField, IntegerField, Model


class Role(Model):
    """
    Represents a role in the system.

    Attributes:
    - role_id (int): The role's ID.
    - employee_id (int): The employee's ID.
    - date_from (str): The date the role is effective from.
    - date_to (str): The date the role is effective to.
    """

    role_id = CharField(unique=True, column_name='role_id', primary_key=True)
    employee_id = IntegerField(column_name='zamestnanec_id')
    date_from = DateField(column_name='od_datum')
    date_to = DateField(column_name='do_datum')

    @dataclass
    class Meta:
        """Metaclass for the Role model."""
        table_name = 'role'
        database = None
