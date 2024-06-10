""" Worker class for handling import-related operations. """
from src.dl.dao.product_dao import ProductDao
from src.dl.dao.branch_dao import BranchDao
from src.dl.dao.import_dao import ImportDao
from src.bl.import_page_interface import ImportPageInterface


class ImportPageWorker(ImportPageInterface):
    """
    Worker class for handling import-related operations.
    """

    def __init__(self):
        """
        Initializes the worker with necessary data access objects.
        """
        self.product = ProductDao()  # Product data access object
        self.branch = BranchDao()  # Branch data access object
        self.imports = ImportDao()  # Import data access object

    def create_supply(self, branch_id):
        """
        Creates a new supply for the given branch ID.

        Args:
            branch_id (int): The ID of the branch.

        Returns:
            int or None: The ID of the created supply if successful, None otherwise.
        """
        return self.imports.create_supply(branch_id)

    def fill_supply(self, supply_id, product_id, amount):
        """
        Fills the supply with the specified product and amount.

        Args:
            supply_id (int): The ID of the supply.
            product_id (int): The ID of the product.
            amount (float): The amount to fill.

        Returns:
            bool: True if successful, False otherwise.
        """
        return self.imports.fill_supply(supply_id, product_id, amount)

    def find_products(self):
        """
        Retrieves a list of all products.

        Returns:
            list[Product]: A list of Product objects.
        """
        return self.product.get_products()

    def product_data_frame(self):
        """
        Retrieves product data as a pandas DataFrame.

        Returns:
            pd.DataFrame: A DataFrame containing product data.
        """
        return self.product.data_frame()

    def find_branches(self, role_id):
        """
        Retrieves a list of branches based on the given role ID.

        Args:
            role_id (int): The ID of the role.

        Returns:
            list[Branch]: A list of Branch objects.
        """
        return self.branch.get_branches(role_id)

    def find_imports(self, branch_id):
        """
        Retrieves a list of imports for the given branch ID.

        Args:
            branch_id (int): The ID of the branch.

        Returns:
            list[Import]: A list of Import objects.
        """
        return self.imports.get_imports(branch_id)

    def supply_data_frame(self, branch_id):
        """
        Retrieves supply data as a pandas DataFrame for the specified branch.

        Args:
            branch_id (int): The ID of the branch.

        Returns:
            pd.DataFrame: A DataFrame containing supply data for the branch.
        """
        return self.imports.data_frame(branch_id)
