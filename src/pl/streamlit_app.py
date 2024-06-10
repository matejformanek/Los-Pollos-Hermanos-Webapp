""" Streamlit application runner """
import streamlit as st
from .login_page import LoginPage
from .main_page import MainPage
from src.bl.login_page_worker import LoginPageWorker


class StreamlitApp:  # pylint: disable=too-few-public-methods
    """ Streamlit runner """
    def run(self):
        """
        Runs the Streamlit application.
        """
        if 'logged_in' not in st.session_state:
            st.session_state['logged_in'] = False
        if 'user' not in st.session_state:
            st.session_state['user'] = None

        if st.session_state['logged_in'] and st.session_state['user']:
            main_page = MainPage()
            main_page.run()
        else:
            login_page = LoginPage(LoginPageWorker())
            login_page.run()


if __name__ == "__main__":
    app = StreamlitApp()
    app.run()
