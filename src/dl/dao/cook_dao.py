""" This module contains the Cook data access object. """
import datetime
from peewee import fn
from src.dl.dao.database_manager import DatabaseManager
from src.dl.entity import Cook, User, Role


class CookDao: # pylint: disable=too-few-public-methods
    """Represents a data access object for cooks."""
    def __init__(self):
        self.db = DatabaseManager().db
        models = Cook, User, Role
        for model in models:
            model.bind(self.db)

    @staticmethod
    def get_cooks():
        """
        Retrieves a list of cooks.

        Returns:
            list[Cook]: A list of Cook objects.
        """
        one_year = (datetime.datetime.now() + datetime.timedelta(days=365)).date()
        cooks = (User.select(User.name, User.email, User.surname,
                             Cook.cook_id, Cook.years_experience)
                 .join(Role, on=User.user_id == Role.employee_id)
                 .join(Cook, on=Role.role_id == Cook.cook_id)
                 .where(fn.coalesce(Role.date_to, one_year) > datetime.datetime.now().date())
                 .objects())
        return cooks
