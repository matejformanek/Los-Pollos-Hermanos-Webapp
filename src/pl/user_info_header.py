""" User info header """
import streamlit as st
from src.pl.logout_page import LogoutPage


class UserInfoHeader: # pylint: disable=too-few-public-methods
    """ User info header """
    def __init__(self):
        self.logout = LogoutPage()

    def show_user_info(self):
        """
        Renders the user information section.
        """
        user = st.session_state.get('user')
        if user:
            col1, col2, _ = st.columns([3, 1, 1])
            with col1:
                st.write(f"Přihlášen: {user}")
            with col2:
                if st.button('Odhlásit se'):
                    self.logout.logout()
