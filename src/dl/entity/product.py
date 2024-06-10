""" This module contains the Product model class. """
from dataclasses import dataclass
from peewee import CharField, FloatField, IntegerField, Model


class Product(Model):
    """
    Represents a product in the system.

    Attributes:
    - product_id (int): The ID of the product (mapped to 'produkt_id' column).
    - price (float): The price of the product (mapped to 'cena' column).
    - name (str): The name of the product (mapped to 'nazev' column).
    - min_purity (float): The minimum purity of the product (mapped to 'procentocistotymin' column).
    - max_purity (float): The maximum purity of the product (mapped to 'procentocistotymax' column).
    - amount (int): The amount of the product (mapped to 'mnozstvi' column, default is 0).
    """
    product_id = IntegerField(column_name='produkt_id', primary_key=True)
    price = FloatField(column_name='cena')
    name = CharField(column_name='nazev')
    min_purity = FloatField(column_name='procentocistotymin')
    max_purity = FloatField(column_name='procentocistotymax')
    amount = IntegerField(column_name='mnozstvi', default=0)

    @dataclass
    class Meta:
        """Metaclass for the Product model."""
        table_name = 'produkt'
        database = None

    def __str__(self):
        """String representation of the Product object."""
        return f"{self.name}"

    def set_amount(self, amount):
        """Set the amount of the product."""
        self.amount = amount
