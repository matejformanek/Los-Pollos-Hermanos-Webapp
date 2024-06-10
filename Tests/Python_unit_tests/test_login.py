""" This module tests the login functionality. """
import sys
import os
import unittest
from io import StringIO
from unittest.mock import patch

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))
from src.dl.dao.login_dao import LoginDao  # pylint: disable=wrong-import-position
from src.pl.login_page import LoginPage  # pylint: disable=wrong-import-position

class TestLogin(unittest.TestCase):
    """ Tests the login functionality."""
    def setUp(self):
        with (patch('src.bl.login_page_worker.LoginPageWorker', autospec=True)
              as mock_login_page_worker):
            self.login_worker = mock_login_page_worker.return_value
            self.login_worker.check_authentication.return_value = 1
            self.login_worker.find_employee.return_value = True

        with (patch('src.pl.login_page.LoginPage', autospec=True)
              as mock_login_page):
            self.login_page = mock_login_page.return_value
            self.login_page.role_id = -1
            self.login_page.login = self.login_worker

            self.login_page.login_user = LoginPage.login_user

    def test_password_is_hashed_correctly(self):
        """
            Tests that the hashing works as expected.
        """
        self.assertEqual(LoginDao.hash_password('heslo'),
                         '56b1db8133d9eb398aabd376f07bf8ab5fc584ea0b8bd6a1770200cb613ca005')
        self.assertEqual(LoginDao.hash_password('hovnokleslo'),
                         '6477ae3fffb4894c7d1fe6c0c0385a3d522b118a8f52ca7000c3a9db895ae691')
        self.assertEqual(LoginDao.hash_password('56b1db8133d9eb398aabd376f07bf'
                                                '8ab5fc584ea0b8bd6a1770200cb613ca005'),
                         '4df13a1a897875527cf2748a24b14347762d9e6e761a98377e2ffd7e108f331b')

    @patch('sys.stdout', new_callable=StringIO)
    def test_login_with_empty_credentials(self, mock_stdout):
        """
            Tests that when empty credentials are given, login fails.
        """
        self.login_page.login_user(self.login_page, "", "")
        self.assertIn('Neplatné přihlašovací údaje', mock_stdout.getvalue())

        self.login_page.login_user(self.login_page, "jmeno", "")
        self.assertIn('Neplatné přihlašovací údaje', mock_stdout.getvalue())

        self.login_page.login_user(self.login_page, "", "heslo")
        self.assertIn('Neplatné přihlašovací údaje', mock_stdout.getvalue())

    @patch('sys.stdout', new_callable=StringIO)
    def test_login_with_credentials(self, mock_stdout):
        """
            Tests the edge cases that can happen when user is logging in.
        """
        self.login_page.login_user(self.login_page, "test", "test")
        self.assertIn('Úspěšně přihlášen.', mock_stdout.getvalue())

        # Error when loading Employee data
        self.login_page.login.find_employee.return_value = False
        self.login_page.login_user(self.login_page, "spatne", "spatne")
        self.assertIn('Chyba při načítání detailů zaměstnance.', mock_stdout.getvalue())

        # Couldn't find active role
        self.login_page.login.check_authentication.return_value = -1
        self.assertIn('Chyba při načítání detailů zaměstnance.', mock_stdout.getvalue())
