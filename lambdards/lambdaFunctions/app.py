import pymysql
import json
import os

def lambda_handler(event, context):
    endpoint = os.environ.get('ENDPOINT')
    username = os.environ.get('USERNAME')
    password = os.environ.get('PASSWORD')
    database_name = os.environ.get('DBNAME')
    # Connection
    connection = pymysql.connect(host=endpoint, user=username, passwd=password, db=database_name)
    cursor = connection.cursor()
    http_method = event['httpMethod']
        
    if http_method == 'GET':
        cursor.execute('SELECT * FROM employee')
        rows = cursor.fetchall()
        results = []
        for row in rows:
            result = {
                'id': row[0],
                'name': row[1],
                'address': row[2],
                'position': row[3],
                'experience': row[4]
            }
            results.append(result)
        json_data = json.dumps(results)
        return {
            "statusCode": 200,
            "body": json_data
        }      
    elif event['httpMethod'] == 'POST':
        #Extract the JSON payload
        data = json.loads(event['body'])
        name = data['name']
        address = data['address']
        position = data['position']
        experience = data['experience']
        # SQL statement to insert data
        sql = "INSERT INTO employee (name, address, position, experience) VALUES (%s, %s, %s, %s)"
        # Execute the SQL statement with the provided data
        cursor.execute(sql, (name, address, position, experience))
        # Commit the changes to the database
        connection.commit()
        # Return success message
        return {
            'statusCode': 200,
            'body': 'Data inserted successfully'
        }
    elif event['httpMethod'] == 'DELETE':
        id_to_delete = event['pathParameters']['id']
        
        sql = "DELETE FROM employee WHERE id = %s"
        # Delete data with the provided ID
        cursor.execute(sql, (id_to_delete,))
        # Commit the changes to the database
        connection.commit()
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Data deleted successfully',
                'id': id_to_delete
            }) 
        }
    elif event['httpMethod'] == 'PUT':
        id_to_update = event['pathParameters']['id']
        # Retrieve the data from the request body
        request_body = json.loads(event['body'])
        name = request_body['name']
        address = request_body['address']
        position = request_body['position']
        experience = request_body['experience']
        
        sql = "UPDATE employee SET name=%s, address=%s, position=%s, experience=%s WHERE id=%s"
        cursor.execute(sql, (name, address, position, experience, id_to_update))

        connection.commit()
        # Return a successful response
        return {
            'statusCode': 200,
            'body': 'Resource updated successfully'
        }