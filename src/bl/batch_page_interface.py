"""
Interface for Batch page
"""


class BatchPageInterface:
    def find_cooks(self):
        pass

    def new_batch(self, email, amount, purity):
        pass

    def find_batches(self):
        pass

    def batch_data_frame(self):
        pass
