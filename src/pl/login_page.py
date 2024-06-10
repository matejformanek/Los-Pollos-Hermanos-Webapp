""" This module contains the LoginPage class, which is responsible for rendering the login page. """
import streamlit as st
from src.bl.login_page_interface import LoginPageInterface


class LoginPage:
    """ Represents the login page."""

    def __init__(self, login_page: LoginPageInterface):
        self.role_id = -1
        self.login = login_page

    def run(self):
        """
        Renders the login page.
        """
        st.title('Přihlášení')
        mail = st.text_input("Email")
        password = st.text_input("Heslo", type="password")

        if st.button('Přihlásit se'):
            self.login_user(mail, password)

    def login_user(self, mail, password):
        """ Logs the user in."""
        if mail == "" or password == "":
            print('Neplatné přihlašovací údaje')
            st.error('Neplatné přihlašovací údaje')
            return

        self.role_id = self.login.check_authentication(mail, password)
        if self.role_id > 0:
            user = self.login.find_employee(self.role_id)
            if user:
                st.session_state['logged_in'] = True
                st.session_state['user'] = user
                print('Úspěšně přihlášen.')
                st.rerun()
            else:
                st.error('Chyba při načítání detailů zaměstnance.')
                print('Chyba při načítání detailů zaměstnance.')
        else:
            st.error('Neplatné přihlašovací údaje')
            print('Neplatné přihlašovací údaje')
