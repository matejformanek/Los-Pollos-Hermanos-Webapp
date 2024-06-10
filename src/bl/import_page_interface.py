"""
Interface for Import page
"""


class ImportPageInterface:
    def create_supply(self, branch_id):
        pass

    def fill_supply(self, supply_id, product_id, amount):
        pass

    def find_products(self):
        pass

    def product_data_frame(self):
        pass

    def find_branches(self, role_id):
        pass

    def find_imports(self, branch_id):
        pass

    def supply_data_frame(self, branch_id):
        pass
