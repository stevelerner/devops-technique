#This example demonstrates infrastructure-as-code using Python / PyCurl / Curl methods to access Digital Ocean
#by Steve Lerner steve@stevelerner.com

import pycurl
import pprint

from StringIO import StringIO

bearer = ' ##put your token here## ' 
url = 'https://api.digitalocean.com/v2/account'

buffer = StringIO()
c = pycurl.Curl()
c.setopt(c.URL, url)
headers = [ 'Content-Type: application/json', 'Authorization: Bearer %s' % bearer ]
c.setopt(c.HTTPHEADER, headers)
c.setopt(c.WRITEDATA, buffer)
c.perform()
c.close()

body = buffer.getvalue()

pp = pprint.PrettyPrinter()
pp.pprint(body)
