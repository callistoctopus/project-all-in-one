# pip install beautifulsoup4
# pip install lxml
# pip install html5lib
from urllib.request import urlopen
from urllib.error import HTTPError
from urllib.error import URLError 
from bs4 import BeautifulSoup 

def getTitle(url): 
    try:         
        html = urlopen(url)     
    except HTTPError as e:
        return None 
    except URLError as e:         
        return None 
    
    try:
        bs = BeautifulSoup(html.read(), 'html.parser') 
        title = bs.body.h1 
    except AttributeError as e:
        return None
        
    return title 

title = getTitle('http://www.pythonscraping.com/pages/page1.html')
if title == None:
    print('Title could not be found') 
else:
    print(title)

html = urlopen('http://www.pythonscraping.com/pages/warandpeace.html') 
bs = BeautifulSoup(html.read(), 'html.parser')
nameList = bs.findAll('span', {'class':'green'}) 
for name in nameList:     
    print(name.get_text())