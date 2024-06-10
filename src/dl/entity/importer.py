""" This module contains the Importer model class. """
from dataclasses import dataclass
from peewee import CharField, IntegerField, Model


class Importer(Model):
    """
    Represents an importer in the system.

    Attributes:
    - importer_id (int): The ID of the importer (mapped to 'dodavatel_id' column).
    - name (str): The name of the importer (mapped to 'nazev' column).
    """
    importer_id = IntegerField(column_name='dodavatel_id', primary_key=True)
    name = CharField(column_name='jmeno_firmy')

    @dataclass
    class Meta:
        """Metaclass for the Importer model."""
        table_name = 'dodavatel'
        database = None

    def __str__(self):
        """String representation of the Importer object."""
        return f"{self.name}"
