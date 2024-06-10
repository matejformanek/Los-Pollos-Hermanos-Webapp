""" This module contains the ProductDao class, which is responsible for"""
from pandas import DataFrame
from src.dl.dao.database_manager import DatabaseManager
from src.dl.entity import Product


# Assuming you have the db object defined as before

class ProductDao:
    """Represents a data access object for products."""
    def __init__(self):
        self.db = DatabaseManager().db

    def get_products(self):
        """
        Retrieves a list of products.

        Returns:
            list[Product]: A list of Product objects.
        """
        products = Product.select(Product.product_id, Product.price,
                                  Product.name, Product.min_purity, Product.max_purity).objects()
        return products

    def data_frame(self):
        """
        Converts the products to a Pandas DataFrame.

        Returns:
            DataFrame: A DataFrame representation of the products.
        """
        products = self.get_products()
        data = [{'price': product.price, 'name': product.name, 'min_purity': product.min_purity,
                 'max_purity': product.max_purity} for product in products] # pylint: disable=not-an-iterable
        return DataFrame(data)
