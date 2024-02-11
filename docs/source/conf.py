# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Jam Launch'
copyright = '2024, The Jam Launch Syndicate'
author = 'Adam'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    "sphinxcontrib.youtube"
]

exclude_patterns = []


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']

html_logo = '_static/docstitle.png'

html_theme_options = {
    'display_version': False,
    'style_nav_header_background': 'rgb(17, 16, 41)',
    'logo_only': True
}

html_context = {
    "display_github": False
}

html_favicon = 'favicon.ico'