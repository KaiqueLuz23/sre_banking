import json
import boto3
from botocore.exceptions import ClientError
from decimal import Decimal

# Inicializa o cliente DynamoDB
dynamodb = boto3.resource('dynamodb', region_name='sa-east-1')
dynamodb_table = dynamodb.Table('srebank_dydb')

def lambda_handler(event, context):
    print('Request event: ', event)
    http_method = event.get('httpMethod')
    path = event.get('path')
    response = None

    if http_method == 'POST' and path == '/debito':
        request_body = json.loads(event['body'])
        documento = request_body.get('documento')
        nome = request_body.get('nome')
        saldo = Decimal(request_body.get('saldo'))
        response = debitar(documento, nome, saldo)
    elif http_method == 'POST' and path == '/transferir':
        request_body = json.loads(event['body'])
        origem_doc = request_body.get('origem_documento')
        origem_nome = request_body.get('origem_nome')
        destino_doc = request_body.get('destino_documento')
        destino_nome = request_body.get('destino_nome')
        saldo = Decimal(request_body.get('saldo'))
        response = transferir(origem_doc, origem_nome, destino_doc, destino_nome, saldo)
    else:
        response = build_response(404, 'Endpoint não encontrado')

    return response


def debitar(documento, nome, saldo_debito):
    try:
        # Recupera o saldo atual do documento e nome especificados
        response = dynamodb_table.get_item(
            Key={'documento': documento, 'nome': nome},
            ProjectionExpression='saldo'
        )
        item = response.get('Item')
        
        if not item:
            return build_response(404, {'error': 'Documento ou nome não encontrado'})

        saldo_atual = Decimal(item.get('saldo'))
        
        # Verifica se o saldo atual é suficiente para o débito
        if saldo_atual < saldo_debito:
            return build_response(400, {'error': 'Saldo insuficiente para realizar o débito'})

        # Atualiza o saldo subtraindo o valor do débito
        novo_saldo = saldo_atual - saldo_debito

        response = dynamodb_table.update_item(
            Key={'documento': documento, 'nome': nome},
            UpdateExpression='SET saldo = :val',
            ExpressionAttributeValues={':val': novo_saldo},
            ReturnValues='UPDATED_NEW'
        )

        return build_response(200, {'message': 'Débito realizado com sucesso'})
    except ClientError as e:
        print('Error:', e)
        return build_response(400, {'error': str(e)})


def transferir(origem_doc, origem_nome, destino_doc, destino_nome, saldo):
    try:
        # Inicia uma transação
        with dynamodb_table.batch_writer() as batch:
            # Debita da conta de origem
            batch.update_item(
                Key={'documento': origem_doc, 'nome': origem_nome},
                UpdateExpression='SET saldo = saldo - :val',
                ExpressionAttributeValues={':val': saldo}
            )
            # Credita na conta de destino
            batch.update_item(
                Key={'documento': destino_doc, 'nome': destino_nome},
                UpdateExpression='SET saldo = saldo + :val',
                ExpressionAttributeValues={':val': saldo}
            )
        return build_response(200, {'message': 'Transferência realizada com sucesso'})
    except ClientError as e:
        print('Error:', e)
        return build_response(400, {'error': str(e)})

def build_response(status_code, body):
    return {
        'statusCode': status_code,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps(body)
    }
