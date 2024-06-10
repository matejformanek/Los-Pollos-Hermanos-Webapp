""" Sphinx configuration file. """
# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

import os
import sys
sys.path.insert(0, os.path.abspath(".."))

project = 'Los Pollos Hermanos'  # pylint: disable=invalid-name, redefined-builtin
copyright = ('2024, Martin Horák, Tomáš Böhm, Markéta Kocourková,'  # pylint: disable=invalid-name, redefined-builtin
             ' Matěj Formánek, Tomáš Krejčík,\xa0Ondřej Sakala, Patrik Cinert')
author = ('Martin Horák, Tomáš Böhm, Markéta Kocourková,'  # pylint: disable=invalid-name, redefined-builtin
          ' Matěj Formánek, Tomáš Krejčík,\xa0Ondřej Sakala, Patrik Cinert')
release = '1.0.0'  # pylint: disable=invalid-name, redefined-builtin

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = ["sphinx.ext.todo", "sphinx.ext.viewcode", "sphinx.ext.autodoc"]

templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']



# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'  # pylint: disable=invalid-name
html_static_path = ['_static']
