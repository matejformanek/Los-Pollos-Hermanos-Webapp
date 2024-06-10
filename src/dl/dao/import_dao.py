""" This module provides a class for interacting with the imports table in the database. """
from pandas import DataFrame
from src.dl.dao.database_manager import DatabaseManager
from src.dl.entity import Import

# Assuming you have the db object defined as before

class ImportDao:
    """Represents a data access object for imports."""
    def __init__(self):
        self.db = DatabaseManager().db
        Import.bind(self.db)

    def create_supply(self, branch_id):
        """
        Creates a new supply for the given branch ID.

        Args:
            branch_id (int): The ID of the branch.

        Returns:
            int or None: The ID of the created supply if successful, None otherwise.
        """
        query = 'SELECT vytvorit_odvoz(%s)'
        with self.db.atomic():
            cursor = self.db.execute_sql(query, (branch_id,))
            supply_id = cursor.fetchone()[0]
            return supply_id if supply_id else None

    def fill_supply(self, supply_id, product_id, amount):
        """
        Fills a supply with the given supply ID, product ID, and amount.

        Args:
            supply_id (int): The ID of the supply.
            product_id (int): The ID of the product.
            amount (float): The amount to fill.
        """
        query = 'CALL fill_odvoz(%s, %s, %s)'
        with self.db.atomic():
            self.db.execute_sql(query, (supply_id, product_id, amount))

    def get_imports(self, branch_id):
        """
        Retrieves a list of supplies associated with the given branch ID.

        Args:
            branch_id (int): The ID of the branch.

        Returns:
            list[Import]: A list of Import objects.
        """
        imports = (Import.select(Import.import_id, Import.state,
                                 Import.order_date, Import.pickup_date, Import.delivery_date)
                   .where(Import.branch_id == branch_id).order_by(Import.import_id.desc())
                   .objects())
        return imports

    def data_frame(self, branch_id):
        """
        Converts the imports to a Pandas DataFrame.

        Args:
            branch_id (int): The ID of the branch.

        Returns:
            DataFrame: A DataFrame representation of the imports.
        """
        #  columns=["Odvoz ID", "Stav", "Datum objednání", "Datum prevzetí", "Datum dovezení"]
        imports = self.get_imports(branch_id)
        data = [{'Odvoz ID': i.import_id, 'Stav': i.state, 'Datum objednání': i.order_date,
                 'Datum prevzetí': i.pickup_date,
                 'Datum dovezení': i.delivery_date} for i in imports]
        return DataFrame(data)
