""" This module contains the Import model class. """
from dataclasses import dataclass
from peewee import CharField, DateField, IntegerField, Model


class Import(Model):
    """
    Represents an Import in the system.

    Attributes:
    - id (int): The supply ID (mapped to 'odvoz_id' column).
    - branch_id (int): The branch ID (mapped to 'pobocka_id' column).
    - driver_id (int): The driver ID (mapped to 'ridic_id' column).
    - state (str): The state of the import (mapped to 'stav' column).
    - order_date (str): The order date (mapped to 'datum_objednani' column).
    - pickup_date (str): The pickup date (mapped to 'datum_prevzeti' column).
    - delivery_date (str): The delivery date (mapped to 'datum_dovezeni' column).
    """
    import_id = IntegerField(column_name='odvoz_id', primary_key=True)
    branch_id = IntegerField(column_name='pobocka_id', null=True)
    driver_id = IntegerField(column_name='ridic_id', null=True)
    state = CharField(column_name='stav', null=True)
    order_date = DateField(column_name='datum_objednani', null=True)
    pickup_date = DateField(column_name='datum_prevzeti', null=True)
    delivery_date = DateField(column_name='datum_dovezeni', null=True)

    @dataclass
    class Meta:
        """Metaclass for the Import model."""
        table_name = 'odvoz'
        database = None

    def __str__(self):
        """String representation of the Import object."""
        return (f"Import ID: {self.import_id}, Branch ID: {self.branch_id},"
                f" Driver ID: {self.driver_id} State: {self.state},"
                f" Order Date: {self.order_date}, Pickup Date: {self.pickup_date}, "
                f"Delivery Date: {self.delivery_date}")
