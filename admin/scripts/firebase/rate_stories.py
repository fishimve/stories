# import random
# import firebase_admin
# from firebase_admin import credentials, firestore

# cred = credentials.Certificate(
#     "scripts/firebase/keys/rubanda_serviceAccountKey.json")

# # cred = credentials.Certificate(
# #     "scripts/firebase/keys/rubanda-development.json")

# firebase_admin.initialize_app(cred)

# # init firestore
# db = firestore.client()

# batch = db.batch()

# # firestore subcollection
# article_docs = db.collection(u'articles').where(
#     u'rating', u'<', 1).order_by(u'rating').stream()

# # # random numbers between 1 and 10000
# randNums = list(range(1, 10000))
# random.shuffle(randNums)

# # incremental
# i = 0

# # write to firestore
# for doc in article_docs:
#     try:
#         doc_ref = db.collection(u'articles').document(doc.id)
#         batch.update(doc_ref, {u'rating': randNums[i]})
#         batch.commit()
#         print(i, "Success to", doc.id, randNums[i])
#         i = i + 1
#     except:
#         print('writing to firestore failed!')
