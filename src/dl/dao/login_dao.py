""" This module contains the LoginDao class which is
 responsible for handling the data access logic for the login """
import hashlib
from src.dl.dao.database_manager import DatabaseManager
from src.dl.entity import User, Role, AccessRightsRole


class LoginDao:
    """ Represents a data access object for login """
    def __init__(self):
        self.db = DatabaseManager().db
        models = User, Role, AccessRightsRole
        for model in models:
            model.bind(self.db)

    def authenticate(self, email, password):
        """
        Checks the authentication of a user with the given email and password hash.

        Args:
            email (str): The email of the user.
            password (str): The password of the user.

        Returns:
            int: The role ID of the user if authentication is successful, -1 otherwise.
        """
        password_hash = self.hash_password(password)

        auth_user = User.get_or_none(User.email == email, User.password == password_hash)
        if auth_user:
            return self.get_role_id(auth_user.user_id)
        return -1

    # Assuming you have the db object defined as before

    @staticmethod
    def get_role_id(user_id):
        """
        Retrieves the role ID of a user with the given user ID by joining the User and Role tables.

        Args:
            user_id (int): The user ID.

        Returns:
            int: The role ID of the user.
        """
        return User.select(Role.role_id).join(Role, on=Role.employee_id == User.user_id).where(
            User.user_id == user_id)

    @staticmethod
    def get_employee_id_by_role(role_id):
        """
        Retrieves the employee ID associated with the given role ID.

        Args:
            role_id (int): The role ID.

        Returns:
            int or None: The employee ID if found, None otherwise.
        """
        # Join employee and role tables
        employee = User.select(User.user_id).join(Role, on=Role.employee_id == User.user_id).where(
            Role.role_id == role_id).first()
        if employee:
            return employee.user_id
        return None

    @staticmethod
    def hash_password(password):
        """
        Hashes the given password using SHA-256 algorithm.

        Args:
            password (str): The password to hash.

        Returns:
            str: The hashed password.
        """
        hasher = hashlib.sha256()
        hasher.update(password.encode('utf-8'))
        return hasher.hexdigest()

    def get_employee(self, role_id):
        """
        Retrieves the details of an employee with the given employee ID and role ID.

        Args:
            role_id (int): The role ID.

        Returns:
            User or None: The User object if employee details are found, None otherwise.
        """
        employee_id = self.get_employee_id_by_role(role_id)
        employee = User.get(User.user_id == employee_id)
        if employee:
            rights = [access_right.access_right_id for access_right in
                      AccessRightsRole.select() # pylint: disable=not-an-iterable
                      .where(AccessRightsRole.role_id == role_id)]
            return User(name=employee.name, surname=employee.surname,
                        employee_id=employee_id, role_id=role_id, rights=rights)
        return None
