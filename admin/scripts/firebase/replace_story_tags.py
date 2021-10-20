import glob
import os

import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate(
    "admin/scripts/firebase/keys/world-stories-collection-firebase-adminsdk-9f29p-dd45a7df50.json")

firebase_admin.initialize_app(cred)

# init firestore
db = firestore.client()

# Replace all tags in all documents by query
# docs = db.collection(u'stories').where(
#     u'author', u'==', u'Andrew Lang\'s').stream()

docs = db.collection(u'stories').where(
    u'tags', u'array_contains', u'18+').stream()

for d in docs:
    doc_ref_story = db.collection(u'stories').document(d.id)
    try:
        # doc_ref_story.update({
        #     u'author': 'Andrew Lang',
        # })
        doc_ref_story.update({
            u'tags': ['Abakuru'],
        })
        print("Success to", doc_ref_story.id)
    except:
        print('writing to firestore failed!')
