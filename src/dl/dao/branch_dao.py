""" This module contains the Branch data access object."""
from src.dl.entity import Branch, AccessRights, Role, AccessRightsRole
from src.dl.dao.database_manager import DatabaseManager

class BranchDao: # pylint: disable=too-few-public-methods
    """Represents a data access object for branches."""
    def __init__(self):
        self.db = DatabaseManager().db
        models = Branch, AccessRights, Role, AccessRightsRole
        for model in models:
            model.bind(self.db)

    def get_branches(self, role_id):
        """
        Retrieves a list of branches associated with the given role ID.

        Args:
            role_id (int): The role ID.

        Returns:
            list[Branch]: A list of Branch objects.
        """
        branches_with_roles = \
            (Role.select(Branch.name, Branch.id.alias('id'))
                 .join(AccessRightsRole, on=Role.role_id == AccessRightsRole.role_id)
                 .join(AccessRights,
                       on=AccessRightsRole.access_right_id == AccessRights.access_right_id)
                 .join(Branch, on=AccessRights.name == Branch.name)
                 .where(role_id == Role.role_id).objects())
        return branches_with_roles
