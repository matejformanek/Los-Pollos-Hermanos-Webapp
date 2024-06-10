""" This module contains the BatchCreatePage class. """
import streamlit as st
from src.bl.batch_page_interface import BatchPageInterface


class BatchCreatePage:  # pylint: disable=too-few-public-methods
    """ Represents the batch creation page."""

    def __init__(self, batch_page: BatchPageInterface):
        self.batch = batch_page

    def show_batch_processing(self):
        """
        Renders the batch processing page.
        """
        st.title('Evidence várky')

        active_cooks = self.batch.find_cooks()
        selected_cook = st.selectbox("Vyberte kuchaře", active_cooks)

        st.write("Navařený produkt")
        amount = st.number_input("Množství (g)", min_value=0)
        purity = st.number_input("Čistota (%)", min_value=0, max_value=100)

        if st.button("Zapsat várku"):
            self.batch.new_batch(selected_cook.email, amount, purity)

        st.write("Várky")
        df = self.batch.batch_data_frame()
        st.dataframe(df, use_container_width=True)
