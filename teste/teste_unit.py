import unittest
import requests
import random
import subprocess

# Chama o comando 'terraform output api_gateway_invoke_url'
output_bytes = subprocess.check_output(['terraform', 'output', 'api_gateway_invoke_url'])
# Converte a saída de bytes para string
api_gateway_invoke_url = output_bytes.decode('utf-8').strip()
# Adiciona "/prod" ao final do URL
base_url = api_gateway_invoke_url + "/prod"
# base_url = 'https://ryp75s8c53.execute-api.sa-east-1.amazonaws.com/prod'

randon_num = str(random.randint(10000, 99999))
rando_saldo = random.randint(10000, 99999)

class TestAPIEndpoints(unittest.TestCase):
    BASE_URL = base_url

    def test_get_status(self):
        response = requests.get(f'{self.BASE_URL}/status')
        self.assertEqual(response.status_code, 200)

    def test_get_extrato(self):
        response = requests.get(f'{self.BASE_URL}/extrato')
        self.assertEqual(response.status_code, 200)

    def test_post_create(self):
        payload = {
            "documento": randon_num,
            "nome": "teste",
            "saldo": rando_saldo
        }
        response = requests.post(f'{self.BASE_URL}/create', json=payload)
        self.assertIn(response.status_code, [200, 201])

    def test_post_debito(self):
        payload = {
            "documento": randon_num,
            "nome": "teste",
            "saldo": rando_saldo
        }
        response = requests.post(f'{self.BASE_URL}/debito', json=payload)
        self.assertIn(response.status_code, [200, 201])

if __name__ == '__main__':
    unittest.main()
