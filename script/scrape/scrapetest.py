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
        data = html.read()
        bs = BeautifulSoup(data, 'html.parser') 
        title = bs.body.h1 
    except AttributeError as e:
        return None
        
    return title 

#http://www.pythonscraping.com/pages/page1.html
title = getTitle('https://www.baidu.com')
if title == None:
    print('Title could not be found') 
else:
    print(title)

#http://www.pythonscraping.com/pages/warandpeace.html
html = urlopen('https://www.baidu.com') 
bs = BeautifulSoup(html.read(), 'html.parser')
nameList = bs.findAll('span', {'class':'green'}) 
for name in nameList:     
    print(name.get_text())
    
html = urlopen('https://baike.baidu.com/item/Python/407313?fr=aladdin') 
bs = BeautifulSoup(html, 'html.parser') 
for link in bs.find_all('a'):     
    if 'href' in link.attrs:         
        print(link.attrs['href'])