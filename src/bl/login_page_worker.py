""" Worker class for handling login and authentication operations. """
from src.dl.dao.login_dao import LoginDao
from src.bl.login_page_interface import LoginPageInterface


class LoginPageWorker(LoginPageInterface):
    """
    Worker class for handling login and authentication operations.
    """

    def __init__(self):
        """
        Initializes the worker with the necessary data access object.
        """
        self.login = LoginDao()  # Login data access object

    def check_authentication(self, mail, password):
        """
        Checks the authentication credentials.

        Args:
            mail (str): The email address of the user.
            password (str): The password provided by the user.

        Returns:
            bool: True if authentication is successful, False otherwise.
        """
        return self.login.authenticate(mail, password)

    def find_employee(self, role_id):
        """
        Retrieves employee details based on the given role ID.

        Args:
            role_id (int): The ID of the role.

        Returns:
            Employee or None: The Employee object if found, None otherwise.
        """
        return self.login.get_employee(role_id)
