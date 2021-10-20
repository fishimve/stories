import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate(
    "admin/scripts/firebase/keys/world-stories-collection-firebase-adminsdk-9f29p-dd45a7df50.json")

firebase_admin.initialize_app(cred)

# init firestore
db = firestore.client()

# delete one document
# doc = db.collection(u'articles').document(u'J5fVSNmpKPsStXz8PERk')
# yes = doc.delete()
# print(yes)

# # Delete all documents by query
# docs = db.collection(u'stories').where(u'language', u'==', u'').stream()

# for d in docs:
#     db.collection(u'stories').document(d.id).delete()
#     print(d.id, 'deleted')
