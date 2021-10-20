# import firebase_admin
# from firebase_admin import credentials, firestore
# from firebase_admin.firestore import SERVER_TIMESTAMP

# cred = credentials.Certificate("scripts/firebase/keys/rubanda_serviceAccountKey.json")
# cred = credentials.Certificate(
#     "scripts/firebase/keys/rubanda-development.json")
# firebase_admin.initialize_app(cred)

# # init firestore
# db = firestore.client()


# batch = db.batch()

# # firestore subcollection
# article_docs = db.collection(u'articles').stream()

# # write to firestore

# for doc in article_docs:
#     try:
#         doc_ref = db.collection(u'articles').document(doc.id)
#         batch.update(doc_ref, {u'language': 'Kinyarwanda'})
#         batch.commit()
#         print("Success to", doc.id)
#     except:
#         print('writing to firestore failed!')
