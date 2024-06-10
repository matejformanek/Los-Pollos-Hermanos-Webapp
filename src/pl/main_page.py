""" This module contains the Cooking class representing cooking information in the system. """
import streamlit as st
from src.pl.user_info_header import UserInfoHeader
from src.pl.batch_create_page import BatchCreatePage
from src.pl.import_create_page import ImportCreatePage

from src.bl.batch_page_worker import BatchPageWorker
from src.bl.import_page_worker import ImportPageWorker


class MainPage:
    """ Represents the main page of the application.q"""
    WAREHOUSE_RIGHTS = 2
    SUPERVISOR_RIGHTS = 5
    BOSS_RIGHTS = 6

    def __init__(self):
        self.user_info = UserInfoHeader()
        self.batch = BatchCreatePage(BatchPageWorker())  # decides which interface to use
        self.imports = ImportCreatePage(ImportPageWorker())  # decides which interface to use

    def run(self):
        """
        Renders the main page of the application.
        """
        self.user_info.show_user_info()

        user = st.session_state.get('user')
        if user:
            self.show_pages(user)
        else:
            st.error('No user selected')
            print('No user selected')

    def show_pages(self, user):
        """ Renders the pages based on the user's rights."""
        user_rights = set(user.rights)

        show_batch = {MainPage.WAREHOUSE_RIGHTS, MainPage.BOSS_RIGHTS}.intersection(user_rights)
        show_transport_request = {MainPage.SUPERVISOR_RIGHTS,
                                  MainPage.BOSS_RIGHTS}.intersection(user_rights)

        if show_batch or show_transport_request:
            tabs = []
            if show_batch:
                tabs.append("Evidence várky")
            if show_transport_request:
                tabs.append("Žádost o odvoz")

            created_tabs = st.tabs(tabs)
            if show_batch:
                with created_tabs[tabs.index("Evidence várky")]:
                    self.batch.show_batch_processing()
            if show_transport_request:
                with created_tabs[tabs.index("Žádost o odvoz")]:
                    self.imports.show_import_request()
        else:
            st.error("Nemáte oprávnění k zobrazení této stránky")
            print("Nemáte oprávnění k zobrazení této stránky")
