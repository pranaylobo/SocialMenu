
from flask import Flask,jsonify
from flask_ngrok import run_with_ngrok
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Use a service account
cred = credentials.Certificate('service.json')
firebase_admin.initialize_app(cred)

app = Flask(__name__)
run_with_ngrok(app)
@app.route('/')
def route():
    
    arr =[]

    db = firestore.client()

    docs = db.collection(u'Recipe').stream()

    for doc in docs:
    # print(f'{doc.id} => {doc.to_dict()}')
        arr.append(doc.to_dict())

    print(arr)
    
    return jsonify(arr)

if __name__ == '__main__':
   app.run()

