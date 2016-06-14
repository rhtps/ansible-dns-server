#!/usr/bin/env python

try:
    # For Python 3.0 and later
    from urllib.request import urlopen
except ImportError:
    # Fall back to Python 2's urllib2
    from urllib2 import urlopen
    import json


def get_jsonparsed_data(url):
    """Receive the content of ``url``, parse it as JSON and return the
    object.
    """
    response = urlopen(url)
    data = str(response.read())
    return json.loads(data)

url = 'https://registry.access.redhat.com/v1/search?q=*'
data = get_jsonparsed_data(url)
for x in data['results']:
    print(x['name'])
