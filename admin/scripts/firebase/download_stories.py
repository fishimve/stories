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
    title = story.get('title')
    json_object = json.dumps(story, indent=4, default=str)

    with open(f'{title}.json', "w") as outfile:
        outfile.write(json_object)



# my_dict = { el.id: el.to_dict() for el in stories_docs }

