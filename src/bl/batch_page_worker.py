""" This module contains the Cooking class representing cooking information in the system. """
from src.dl.dao.batch_dao import BatchDao
from src.dl.dao.cook_dao import CookDao
from src.bl.batch_page_interface import BatchPageInterface


class BatchPageWorker(BatchPageInterface):
    """
    Worker class for handling batch-related operations.
    """

    def __init__(self):
        """
        Initializes the worker with necessary data access objects.
        """
        self.cook = CookDao()  # Cook data access object
        self.batch = BatchDao()  # Batch data access object

    def find_cooks(self):
        """
        Retrieves a list of all cooks.

        Returns:
            list[Cook]: A list of Cook objects.
        """
        return self.cook.get_cooks()

    def new_batch(self, email, amount, purity):
        """
        Creates a new batch with the given cook's email, amount, and purity.

        Args:
            email (str): The email address of the cook.
            amount (float): The amount for the batch.
            purity (float): The purity of the batch.
        """
        self.batch.new_batch(email, amount, purity)

    def find_batches(self):
        """
        Retrieves a list of all batches.

        Returns:
            list[Batch]: A list of Batch objects.
        """
        return self.batch.get_batches()

    def batch_data_frame(self):
        """
        Retrieves batch data as a pandas DataFrame.

        Returns:
            pd.DataFrame: A DataFrame containing batch data.
        """
        return self.batch.data_frame()
