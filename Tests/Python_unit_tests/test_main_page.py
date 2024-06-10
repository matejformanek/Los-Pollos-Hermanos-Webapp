""" This module tests the main page functionality."""
import sys
import os
import unittest
from io import StringIO
from unittest.mock import patch

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))
from src.pl.main_page import MainPage  # pylint: disable=wrong-import-position

class TestMainPage(unittest.TestCase):
    """ Tests the main page functionality."""
    def setUp(self):
        with patch('src.pl.user_info_header.UserInfoHeader',
                   autospec=True) as mock_user_info_header:
            self.user_info_header = mock_user_info_header.return_value

            def shi():
                print('User info got')

            self.user_info_header.show_user_info.side_effect = shi

        with patch('src.pl.batch_create_page.BatchCreatePage',
                   autospec=True) as mock_batch_create_page:
            self.batch_create_page = mock_batch_create_page.return_value

            def sbp():
                print('batch shown')

            self.batch_create_page.show_batch_processing.side_effect = sbp

        with patch('src.pl.import_create_page.ImportCreatePage',
                   autospec=True) as mock_import_create_page:
            self.import_create_page = mock_import_create_page.return_value

            def sir():
                print('import shown')

            self.import_create_page.show_import_request.side_effect = sir

        with patch('src.pl.main_page.MainPage', autospec=True) as mock_main_page:
            self.main_page = mock_main_page.return_value
            self.main_page.run = MainPage.run
            self.main_page.show_pages = MainPage.show_pages

            self.main_page.user_info = self.user_info_header
            self.main_page.batch = self.batch_create_page
            self.main_page.imports = self.import_create_page

    @patch('sys.stdout', new_callable=StringIO)
    def test_get_session_user(self, mock_stdout):
        """ Tests the get session user method."""
        self.main_page.run(self.main_page)
        self.assertIn('User info got', mock_stdout.getvalue())
        self.assertIn('No user selected', mock_stdout.getvalue())

    @patch('sys.stdout', new_callable=StringIO)
    def test_show_none_pages(self, mock_stdout):
        """ Tests the show pages method with no rights."""
        class User: # pylint: disable=too-few-public-methods
            """ Represents a user."""
            def __init__(self):
                self.rights = {}

        self.main_page.show_pages(self.main_page, User())
        self.assertIn('Nemáte oprávnění k zobrazení této stránky', mock_stdout.getvalue())
        self.assertNotIn('batch shown', mock_stdout.getvalue())
        self.assertNotIn('import shown', mock_stdout.getvalue())

    @patch('sys.stdout', new_callable=StringIO)
    def test_show_all_pages(self, mock_stdout):
        """ Tests the show pages method with all rights."""
        class User: # pylint: disable=too-few-public-methods
            """ Represents a user."""
            def __init__(self):
                self.rights = {2, 5, 6}

        self.main_page.show_pages(self.main_page, User())
        self.assertIn('batch shown', mock_stdout.getvalue())
        self.assertIn('import shown', mock_stdout.getvalue())
        self.assertNotIn('Nemáte oprávnění k zobrazení této stránky', mock_stdout.getvalue())

    @patch('sys.stdout', new_callable=StringIO)
    def test_show_only_batch_page(self, mock_stdout):
        """ Tests the show pages method with only batch rights."""
        class User: # pylint: disable=too-few-public-methods
            """ Represents a user."""
            def __init__(self):
                self.rights = {2}

        self.main_page.show_pages(self.main_page, User())
        self.assertIn('batch shown', mock_stdout.getvalue())
        self.assertNotIn('import shown', mock_stdout.getvalue())
        self.assertNotIn('Nemáte oprávnění k zobrazení této stránky', mock_stdout.getvalue())

    @patch('sys.stdout', new_callable=StringIO)
    def test_show_only_import_page(self, mock_stdout):
        """ Tests the show pages method with only import rights."""
        class User: # pylint: disable=too-few-public-methods
            """ Represents a user."""
            def __init__(self):
                self.rights = {5}

        self.main_page.show_pages(self.main_page, User())
        self.assertNotIn('batch shown', mock_stdout.getvalue())
        self.assertIn('import shown', mock_stdout.getvalue())
        self.assertNotIn('Nemáte oprávnění k zobrazení této stránky', mock_stdout.getvalue())
