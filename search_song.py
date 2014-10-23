# Search selected song on Google

import os
from urllib import quote_plus

query = "{query}"

os.system("open 'https://www.google.com/search?q=" + quote_plus(query) + "'");