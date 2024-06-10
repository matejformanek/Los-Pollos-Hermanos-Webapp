"""
Interface for Login page
"""


class LoginPageInterface:
    def check_authentication(self, mail, password):
        pass

    def find_employee(self, role_id):
        pass
