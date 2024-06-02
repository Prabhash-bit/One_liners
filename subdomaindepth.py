import requests
from bs4 import BeautifulSoup
from googlesearch import search

def find_subdomains_multi_depth(domain, max_depth=5, current_depth=1, subdomains=None):
    # Base case - When no new subdomains are found or the max depth reached
    if subdomains is None or current_depth > max_depth:
        return

    # Construct Google dork query
    query = f'inurl:{domain} site:*.{domain}'

    # Execute Google search
    result_links = []
    for j in search(query, tld='co.in', num=10, stop=10, pause=2):
        result_links.append(j)

    # Extract possible subdomains from links
    subdomains_list = []
    for i in result_links:
        split_url = i.split('//')
        
        if len(split_url) > 1:
            possible_subdomain = split_url[1]
            
            further_split_link = possible_subdomain.split('/')
            actual_subdomain = further_split_link[0]
            
            if actual_subdomain not in subdomains_list:
                subdomains_list.append(actual_subdomain)

    # Write each subdomain into text file
    with open(f'{domain}_subdomains_{current_depth}.txt', 'w+') as f:
         for link in subdomains_list:
              f.write(link+'\n')

    print(f'Sub-domains stored successfully in {domain}_subdomains_{current_depth}.txt')   

    # Recursive call for each identified subdomain
    if current_depth < max_depth:
        for sd in subdomains_list:
            next_domain = sd + '.' + domain
            find_subdomains_multi_depth(next_domain, max_depth, current_depth+1, subdomains=subdomains_list)


# Request user input for primary domain
domain = input('Enter the domain: ')

# Start the sub-domain discovery process
find_subdomains_multi_depth(domain)