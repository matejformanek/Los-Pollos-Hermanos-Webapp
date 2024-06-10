""" This module contains the Batch data access object. """
import pandas as pd
from src.dl.entity import Batch, Product, Cooking
from src.dl.dao.database_manager import DatabaseManager


class BatchDao:
    """Represents a data access object for batches."""
    def __init__(self):
        self.db = DatabaseManager().db
        models = Batch, Product, Cooking
        for model in models:
            model.bind(self.db)

    def new_batch(self, cook: str, amount: float, purity: float):
        """
        Creates a new batch with the given cook, amount, and purity.

        Args:
            cook (str): email of the cook.
            amount (float): The amount of the batch.
            purity (float): The purity of the batch.
        """
        query = 'CALL novavarka(%s, %s, %s)'
        with self.db.atomic():
            self.db.execute_sql(query, (amount, purity, cook))

    @staticmethod
    def get_batches():
        """
        Retrieves a list of batches.

        Returns:
            list[Batch]: A list of Batch objects.
        """
        batches = (Batch.select(Product.name, Batch.amount, Batch.state, Cooking.date)
                   .join(Product, on=Batch.product_id == Product.product_id)
                   .join(Cooking, on=Cooking.cooking_id == Batch.batch_id)
                   .order_by(Batch.batch_id.desc())
                   .objects())
        return batches

    def data_frame(self):
        """
        Converts the batches to a Pandas DataFrame.

        Returns:
            DataFrame: A DataFrame representation of the batches.
        """
        batches = self.get_batches()
        # Print batch column names
        data = [{'Název': batch.name, 'Množství uvařeno': batch.amount,
                 'Stav': batch.state, 'Datum': batch.date}
                for batch in batches]
        return pd.DataFrame(data)
