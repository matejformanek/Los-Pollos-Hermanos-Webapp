""" This module contains the Batch model class. """
from dataclasses import dataclass
from peewee import CharField, DecimalField, IntegerField, Model

class Batch(Model):
    """
    Represents a batch in the system.

    Attributes:
    - batch_id (int): The ID of the batch (mapped to 'varka_id' column).
    - product_id (int): The ID of the product (mapped to 'produkt_id' column).
    - amount (float): The amount of the batch (mapped to 'mnozstvi_uvareno' column).
    - state (str): The state of the batch (mapped to 'stav' column).
    - purity (float): The purity of the batch (mapped to 'kvalita' column).
    """
    batch_id = IntegerField(column_name='varka_id', primary_key=True)
    product_id = IntegerField(column_name='produkt_id')
    amount = DecimalField(column_name='mnozstvi_uvareno')
    state = CharField(column_name='stav')
    purity = DecimalField(column_name='kvalita')

    @dataclass
    class Meta:
        """Metaclass for the Batch model."""
        table_name = 'varka'
        database = None
