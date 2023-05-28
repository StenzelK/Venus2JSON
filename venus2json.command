#!/usr/bin/env python
import glob
from bs4 import BeautifulSoup
import json
import os
import re
import colorama
from colorama import Fore, Style

def main():


    colorama.init(autoreset=True)
    print(f"\n\n{Fore.GREEN}Scanning for chat files....")
    output_dir = "output"

    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    json_tmp = '''
    {
        "type": "risuChat",
        "ver": 1,
        "data": {
            "message": [],
            "note": "",
            "name": "RIP_Venus",
            "localLore": [],
            "lastMemory": "NewChat"
        }
    }
    '''

    json_template = json.loads(json_tmp)


    html_files = glob.glob("HTML_HERE/*.html") + glob.glob("HTML_HERE/*.htm")

    soup_dict = {}


    for file in html_files:

        with open(file, "r") as f:
            content = f.read()

        soup = BeautifulSoup(content, "html.parser")
        
        result = soup.find('meta', attrs={'property': 'og:site_name', 'content': 'VenusAI'}) is not None

        if not result:
            print(f"{file} might not be from VenusAI")
            continue
        
        match = re.search(r"with\s(.+)\.(html|htm)", file)
        if match:
            name = match.group(1)
        else:
            name = ""

            
        if name:
            print(f"Converting chat with {Fore.CYAN}{name}{Style.RESET_ALL}...")
        else:
            print("Converting unknown chat...")

        divs = soup.find_all("div", class_="ant-list-item-meta-description")
        
        filtered_divs = [div.find("div", class_="sc-ispOId iwUCwW").decode_contents() for div in divs if div.find("div", class_="sc-ispOId iwUCwW")]

        for i, text in enumerate(filtered_divs):
            
            role = "user" if i % 2 != 0 else "char"

            
            msg = {"role": role, "data": text}
            
            json_template["data"]["message"].append(msg)
            
        filename = os.path.basename(file)
        file_json = filename.replace(".html", ".json").replace(".htm", ".json")
        output_path = os.path.join(output_dir, file_json)
        
        with open(output_path, "w") as ff:
            json.dump(json_template, ff)
            
        if name:
            print(f"Your chat with {Fore.CYAN}{name}{Style.RESET_ALL} has been converted")
        else:
            print("Your chat has been converted")
        
    
    print(f"{Fore.GREEN}All possible chats have been converted. Say Hi to your waifu/husbando from me")
    
if __name__ == '__main__':
    main()