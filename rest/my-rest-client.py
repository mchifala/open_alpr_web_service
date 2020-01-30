from __future__ import print_function
import requests
import json
import argparse
import time
from statistics import mean
import redis
import os.path

def upload_pic(address, image_file):
    """
    This function uploads an image in binary format to the REST API image endpoint

    Parameters:
    - address(str): the host IP address, ex. 0.0.0.0
    - image_fie(str): the image file name, ex. test.png

    Returns:
    - response(jsonpickle object): If request is successful, the response to the client
    is a HTTP 200 code and the hash of the image. If request is unsuccessful, the Response
    is a HTTP 500 code and the associated error.

    """
    headers = {'content-type': 'image/png'}
    img = open(image_file, 'rb').read()
    image_url = address + '/image/'+os.path.basename(image_file)
    return requests.put(image_url, data=img, headers=headers)

def get_plates(address, hash):
    """
    This function uploads an MD5 hash to the REST API hash endpoint

    Parameters:
    - address(str): the host IP address, ex. 0.0.0.0
    - hash(str): the MD5 hash of an image we wish to query

    Returns:
    - response(jsonpickle object): If request is successful, the response to the client
    is a HTTP 200 code and the plates associated with the hash value. If request is
    unsuccessful, the Response is a HTTP 500 code and the associated error.

    """
    plates_url = address + "/hash/"+hash
    return requests.get(plates_url, data={})

def get_hashes(address, license):
    """
    This function uploads a license plate number to the REST API license endpoints

    Parameters:
    - address(str): the host IP address, ex. 0.0.0.0
    - license(str): a license plate we wish to query

    Returns:
    - response(jsonpickle object): If request is successful, the response to the client
    is a HTTP 200 code and the hash values associated with the plate. If request is
    unsuccessful, the Response is a HTTP 500 code and the associated error.
    
    """
    license_url = address + "/license/"+license
    return requests.get(license_url, data={})

def main(server_address, endpoint, image_file, hash, license):
    address = 'http://'+server_address+':5000'

    if endpoint == "image":
        response = upload_pic(address, image_file).json()
        print(response)

    elif endpoint == "hash":
        response = get_plates(address, hash).json()
        print(response)

    elif endpoint == "license":
        response = get_hashes(address, license).json()
        print(jsonpickle.decode(response))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="REST API")

    parser.add_argument('server_address',
                        type=str,
                        help='Address of the server ex. localhost')

    parser.add_argument('endpoint',
                        type=str,
                        help='The endpoint of the server we wish to query')

    parser.add_argument('--image_file',
                        type=str,
                        help='The file we wish to upload')

    parser.add_argument('--hash',
                        type=str,
                        help='The hash of an image we wish to query')

    parser.add_argument('--license',
                        type=str,
                        help='A license plate we wish to query')

    args = parser.parse_args()
    main(args.server_address, args.endpoint, args.image_file, args.hash, args.license)
