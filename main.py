""" Main file to run the Streamlit app. """

from src.pl.streamlit_app import StreamlitApp

if __name__ == "__main__":
    app = StreamlitApp()
    app.run()
