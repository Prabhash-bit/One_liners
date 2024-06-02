import requests
from googlesearch import search

def perform_search(domain, queries):
    """
    Executes a series of Google Searches for mentioned queries within a specified domain, printing and saving found URLs to a file.
    """

    # Prepare output file
    filename = "discovered_urls.txt"
    urls_file = open(filename, "w+")

    # Compile list of queries
    for query in queries:
        try:
            # Formulate Google search string
            query_string = f'{query} site:{domain}'

            # Initiate search & save URLs
            results_gen = search(query_string)

            for result in results_gen:
                print(f'Result found for "{query}": {result}')
                urls_file.write(f'{result}\n')

        except Exception as e:
            print(f'An exception occurred during processing of query "{query}": {str(e)}')
          
    # Finalize operation by closing file
    urls_file.close()


queries = [
    '"inurl:q=" OR "inurl:s=" OR "inurl:search=" OR "inurl:query=" OR "inurl:keyword=" OR "inurl:lang="',
    '"inurl:demo" OR "inurl:dev" OR "inurl:staging" OR "inurl:test" OR "inurl:sandbox"',
    '"intext:error" OR "intext:exception" OR "intext:not found" OR "intext:failed"'
]


if __name__ == "__main__":
    # User Input
    domain = input("Please enter the domain name: ")

    # Begin searching
    perform_search(domain, queries)