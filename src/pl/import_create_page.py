""" This module contains the ImportCreatePage class. """
import streamlit as st
from src.bl.import_page_interface import ImportPageInterface


class ImportCreatePage:  # pylint: disable=too-few-public-methods
    """ Represents the import creation page."""
    def __init__(self, import_page: ImportPageInterface):
        self.imports = import_page

    def show_import_request(self):
        """
        Renders the transport request page.
        """
        st.title('Žádost o odvoz')
        user = st.session_state.get('user')

        branches = self.imports.find_branches(user.role_id)
        selected_branch = st.selectbox("Vyberte pobočku", branches,
                                       format_func=lambda branch: branch.name)

        products = self.imports.find_products()

        st.write("Produkty:")
        df = self.imports.product_data_frame()
        st.dataframe(df, use_container_width=True)

        total_price = 0
        for product in products: # pylint: disable=not-an-iterable
            col1, _ = st.columns([1, 1])
            with col1:
                product.set_amount(st.number_input(f"Množství ({product.name})", min_value=0))
                total_price += product.price * product.amount

        st.write(f"Celková cena: {total_price}")

        if st.button("Odeslat požadavek"):
            supply_id = self.imports.create_supply(selected_branch.id)
            for product in products: # pylint: disable=not-an-iterable
                self.imports.fill_supply(supply_id, product.product_id, product.amount)

        st.write("Poslední odvozy:")
        df = self.imports.supply_data_frame(selected_branch.id)
        st.dataframe(df, use_container_width=True)
