import firebase_admin
from firebase_admin import credentials, firestore
import json

cred = credentials.Certificate(
    "admin/scripts/firebase/keys/world-stories-collection-firebase-adminsdk-9f29p-dd45a7df50.json")

firebase_admin.initialize_app(cred)

# init firestore
db = firestore.client()

batch = db.batch()

stories_docs = db.collection(u'stories').where(
    u'language', u'==', u'Kinyarwanda').stream()

for doc in stories_docs:
    story = doc.to_dict()
    id = story.get('id')
    json_object = json.dumps(story, indent=4, default=str)

    with open(f'{id}.json', "w") as outfile:
        outfile.write(json_object)




