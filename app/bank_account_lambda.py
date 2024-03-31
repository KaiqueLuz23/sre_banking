import json
import boto3
from botocore.exceptions import ClientError
from decimal import Decimal
from boto3.dynamodb.conditions import Key

# Inicializa o cliente DynamoDB
dynamodb = boto3.resource('dynamodb', region_name='sa-east-1')
dynamodb_table = dynamodb.Table('srebank_dydb')

create_path = '/create'

def lambda_handler(event, context):
    print('Request event: ', event)
    response = None
   
    try:
        http_method = event.get('httpMethod')
        path = event.get('path')

        if http_method == 'GET' and path == create_path:
            documento_id = event['queryStringParameters']['documento']
            response = get_create(documento_id)
        elif http_method == 'POST' and path == create_path:
            response = save_create(json.loads(event['body']))
        elif http_method == 'PATCH' and path == create_path:
            body = json.loads(event['body'])
            response = modify_create(body['documento'], body['updateKey'], body['updateValue'])
        elif http_method == 'DELETE' and path == create_path:
            body = json.loads(event['body'])
            response = delete_create(body['documento'])
        elif http_method == 'PUT' and path == create_path:
            body = json.loads(event['body'])
            response = update_create(body['documento'], body['updateKey'], body['updateValue'])            
        else:
            response = build_response(404, '404 Not Found')

    except Exception as e:
        print('Error:', e)
        response = build_response(400, 'Error processing request')
   
    return response

def get_create(documento_id):
    try:
        response = dynamodb_table.get_item(Key={'documento': documento_id})
        return build_response(200, response.get('Item'))
    except ClientError as e:
        print('Error:', e)
        return build_response(400, e.response['Error']['Message'])

def save_create(request_body):
    # Verifica se os campos "nome" e "documento" estão presentes no corpo da solicitação
    if 'nome' not in request_body or 'documento' not in request_body:
        return build_response(400, {'error': 'Os campos "nome" e "documento" são obrigatórios'})

    try:
        dynamodb_table.put_item(Item=request_body)
        body = {
            'Operation': 'SAVE',
            'Message': 'SUCCESS',
            'Item': request_body
        }
        return build_response(200, body)
    except ClientError as e:
        print('Error:', e)
        return build_response(400, e.response['Error']['Message'])

def modify_create(documento_id, update_key, update_value):
    try:
        response = dynamodb_table.update_item(
            Key={'documento': documento_id},
            UpdateExpression=f'SET {update_key} = :value',
            ExpressionAttributeValues={':value': update_value},
            ReturnValues='UPDATED_NEW'
        )
        body = {
            'Operation': 'UPDATE',
            'Message': 'SUCCESS',
            'UpdatedAttributes': response
        }
        return build_response(200, body)
    except ClientError as e:
        print('Error:', e)
        return build_response(400, e.response['Error']['Message'])

def update_create(documento_id, update_key, update_value):
    try:
        response = dynamodb_table.update_item(
            Key={'documento': documento_id},
            UpdateExpression=f'SET {update_key} = :value',
            ExpressionAttributeValues={':value': update_value},
            ReturnValues='UPDATED_NEW'
        )
        body = {
            'Operation': 'UPDATE',
            'Message': 'SUCCESS',
            'UpdatedAttributes': response
        }
        return build_response(200, body)
    except ClientError as e:
        print('Error:', e)
        return build_response(400, e.response['Error']['Message'])    

def delete_create(documento_id):
    try:
        response = dynamodb_table.delete_item(
            Key={'documento': documento_id},
            ReturnValues='ALL_OLD'
        )
        body = {
            'Operation': 'DELETE',
            'Message': 'SUCCESS',
            'Item': response
        }
        return build_response(200, body)
    except ClientError as e:
        print('Error:', e)
        return build_response(400, e.response['Error']['Message'])

class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Decimal):
            # Verifica se é int ou float
            if obj % 1 == 0:
                return int(obj)
            else:
                return float(obj)
        # Deixa o método padrão da classe base levantar o TypeError
        return super(DecimalEncoder, self).default(obj)

def build_response(status_code, body):
    return {
        'statusCode': status_code,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps(body, cls=DecimalEncoder)
    }
