""" This module contains the LogoutPage class which represents the logout page. """
import streamlit as st


class LogoutPage: # pylint: disable=too-few-public-methods
    """ Represents the logout page."""
    def logout(self):
        """
        Logs out the user by clearing the session state.
        """
        for key in list(st.session_state.keys()):
            del st.session_state[key]
        st.rerun()
